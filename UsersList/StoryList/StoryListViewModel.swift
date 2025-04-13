//
//  StoryListViewModel.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation
import SwiftUI
import Combine

class StoryListViewModel: ObservableObject {
    private var dataProvider: DataProviderProtocol
    private var storyHandler: StoryHandlerProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var pages: Pages?
    @Published var error: DataError?
    @Published var seenIds = [Int]()
    
    init(dataProvider: DataProviderProtocol,
         storyHandler: StoryHandlerProtocol) {
        
        self.dataProvider = dataProvider
        self.storyHandler = storyHandler
        
        fetchStoryList()
    }
    
    func fetchStoryList() {
        do {
            pages = try dataProvider.fetchData()
        } catch {
            self.error = error
        }
    }
    
    func didDismissErrorAlert() {
        error = nil
    }
    
    func onAppear() {
        seenIds = storyHandler.seenIds
    }
    
    func loadMore() {
        do {
            pages = try dataProvider.loadMoreData()
        } catch {
            self.error = error
        }
    }
    
    func detailsView(user: User) -> StoryView {
        let userDefaults = UserDefaultsHandler()
        let storyHandler = StoryHandler(userDefaults: userDefaults)
        let detailsViewModel = StoryViewViewModel(
            storyHandler: storyHandler,
            user: user,
            dataProvider: dataProvider
        )
        return StoryView(viewModel: detailsViewModel)
    }
}

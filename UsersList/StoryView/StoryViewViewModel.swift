//
//  StoryViewViewModel.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation

final class StoryViewViewModel: ObservableObject {
    private let storyHandler: StoryHandlerProtocol
    private let dataProvider: DataProviderProtocol
    
    @Published var user: User
    @Published var isLiked: Bool = false
    
    var canNavigateLeft: Bool {
        dataProvider.hasPreviousUser(currentUserId: user.id)
    }
    
    var canNavigateRight: Bool {
        dataProvider.hasNextUser(currentUserId: user.id)
    }
    
    init(storyHandler: StoryHandlerProtocol, user: User, dataProvider: DataProviderProtocol) {
        self.storyHandler = storyHandler
        self.user = user
        self.dataProvider = dataProvider
        handleUser()
    }
    
    func didTapLike() {
        isLiked ? unlike() : like()
    }
    
    func didTapRight () {
        guard let nextUser = dataProvider.getNextUser(currentUserId: user.id) else {
            return
        }
        user = nextUser
        handleUser()
    }
    
    func didTapLeft () {
        guard let previousUser = dataProvider.getPreviousUser(currentUserId: user.id) else {
            return
        }
        user = previousUser
        handleUser()
    }
    
    private func handleUser() {
        isLiked = storyHandler.isLiked(id: user.id)
        storyHandler.markAsSeen(id: user.id)
    }
    
    private func like() {
        storyHandler.markAsLiked(id: user.id)
        isLiked = true
    }
    
    private func unlike() {
        storyHandler.unmarkAsLiked(id: user.id)
        isLiked = false
    }
    
}

//
//  UsersListApp.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import SwiftUI

@main
struct UsersListApp: App {
    var body: some Scene {
        let userDefaultsHandler = UserDefaultsHandler()
        let storyHandler = StoryHandler(userDefaults: userDefaultsHandler)
        let viewModel = StoryListViewModel(dataProvider: DataProvider(), storyHandler: storyHandler)
        WindowGroup {
            StoryList(viewModel: viewModel)
        }
    }
}

//
//  StoryHandler.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation
import Combine

protocol StoryHandlerProtocol {
    func markAsSeen(id: Int)
    func markAsLiked(id: Int)
    func unmarkAsLiked(id: Int)
    func isLiked(id: Int) -> Bool
    
    var seenIds: [Int] { get }
}

final class StoryHandler: StoryHandlerProtocol {
    private let userDefaults: UserDefaultsHandlerProtocol
    
    var seenIds: [Int] {
        userDefaults.seenIds
    }
    
    init(userDefaults: UserDefaultsHandlerProtocol) {
        self.userDefaults = userDefaults
    }
    
    func isLiked(id: Int) -> Bool {
        userDefaults.likedIds.contains(id)
    }
    
    func markAsSeen(id: Int) {
        userDefaults.setSeen(id: id)
    }
    func markAsLiked(id: Int) {
        userDefaults.setLiked(id: id)
    }
    
    func unmarkAsLiked(id: Int) {
        userDefaults.setUnLiked(id: id)
    }
}

//
//  UserDefaultsHandler.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation

protocol UserDefaultsHandlerProtocol {
    func setSeen(id: Int)
    func setLiked(id: Int)
    func setUnLiked(id: Int)
    
    var seenIds: [Int] { get }
    var likedIds: [Int] { get }
}

final class UserDefaultsHandler: UserDefaultsHandlerProtocol {
    var seenIds: [Int] {
        defaultsContainer.array(forKey: seenKey) as? [Int] ?? []
    }
    
    var likedIds: [Int] {
        defaultsContainer.array(forKey: likedKey) as? [Int] ?? []
    }
    
    let seenKey = "seenStoryIds"
    let likedKey = "likedStoryIds"
    
    let defaultsContainer: UserDefaults
    
    init(defaultsContainer: UserDefaults = .standard) {
        self.defaultsContainer = defaultsContainer
    }
    
    func setSeen(id: Int) {
        var seenIds = Set(self.seenIds)
        seenIds.insert(id)
        defaultsContainer.set(Array(seenIds), forKey: seenKey)
    }
    
    func setLiked(id: Int) {
        var likedIds = Set(self.likedIds)
        likedIds.insert(id)
        defaultsContainer.set(Array(likedIds), forKey: likedKey)
    }
    
    func setUnLiked(id: Int) {
        var likedIds = self.likedIds
        if let index = likedIds.firstIndex(of: id) {
            likedIds.remove(at: index)
            defaultsContainer.set(likedIds, forKey: likedKey)
        }
    }
}

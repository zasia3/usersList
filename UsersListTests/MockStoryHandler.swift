//
//  MockStoryHandler.swift
//  UsersListTests
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation
@testable import UsersList

class MockStoryHandler: StoryHandlerProtocol {
    
    
    func markAsSeen(id: Int) {
    
    }
    
    func markAsLiked(id: Int) {
        
    }
    
    func unmarkAsLiked(id: Int) {
        
    }
    
    var shoulBeLiked: Bool = false
    func isLiked(id: Int) -> Bool {
        shoulBeLiked
    }
    
    var seenIds: [Int] = []
    
    
}

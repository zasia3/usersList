//
//  MockDataProvider.swift
//  UsersListTests
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation
@testable import UsersList

class MockDataProvider: DataProviderProtocol {
    
    var pagesToReturn: UsersList.Pages?
    func fetchData() throws(UsersList.DataError) -> UsersList.Pages {
        if let pagesToReturn {
            return pagesToReturn
        }
        throw UsersList.DataError.noData
    }
    var morePagesToReturn: UsersList.Pages?
    func loadMoreData() throws(UsersList.DataError) -> UsersList.Pages {
        if let morePagesToReturn {
            return morePagesToReturn
        }
        throw UsersList.DataError.noData
    }
    
    var previousUserToReturn: UsersList.User?
    func getPreviousUser(currentUserId: Int) -> UsersList.User? {
        previousUserToReturn
    }
    
    var nextUserToReturn: UsersList.User?
    func getNextUser(currentUserId: Int) -> UsersList.User? {
        nextUserToReturn
    }
    
    var hasPreviousUserToReturn: Bool = false
    func hasPreviousUser(currentUserId: Int) -> Bool {
        hasPreviousUserToReturn
    }
    
    var hasNextUserToReturn: Bool = false
    func hasNextUser(currentUserId: Int) -> Bool {
        hasNextUserToReturn
    }
    
    
}

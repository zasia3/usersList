//
//  DataProvider.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation

enum DataError: LocalizedError {
    case noData
    case loadingFailed
    case decodingFailed
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "No data found"
        case .loadingFailed:
            return "Failed to load data"
        case .decodingFailed:
            return "Failed to decode data"
        }
    }
    var errorDescription: String {
        localizedDescription
    }
}

protocol DataProviderProtocol {
    func fetchData() throws(DataError) -> Pages
    func loadMoreData() throws(DataError) -> Pages
    func getPreviousUser(currentUserId: Int) -> User?
    func getNextUser(currentUserId: Int) -> User?
    func hasPreviousUser(currentUserId: Int) -> Bool
    func hasNextUser(currentUserId: Int) -> Bool
}

final class DataProvider: DataProviderProtocol {
    
    private var data: Pages?
    private var users: [User] {
        return data?.pages.flatMap { $0.users } ?? []
    }
    
    func fetchData() throws(DataError) -> Pages {
        let pages = try readData()
        self.data = pages
        return pages
    }
    
    func loadMoreData() throws(DataError) -> Pages {
        let pages = try readData()
        let newUsers = users.map { User(user: $0, idOffset: users.count) }
        let duplicatedPages = pages.pages + [Page(users: newUsers)]
        let newPages = Pages(pages: duplicatedPages)
        
        self.data = newPages
        return newPages
    }
    
    func getPreviousUser(currentUserId: Int) -> User? {
        guard let currentUserIndex = currentUserIndex(id: currentUserId),
              currentUserIndex > 0 else {
            return nil
        }
        return users[currentUserIndex - 1]
    }
    
    func getNextUser(currentUserId: Int) -> User? {
        guard let currentUserIndex = currentUserIndex(id: currentUserId),
              currentUserIndex < users.count - 1 else {
            return nil
        }
        return users[currentUserIndex + 1]
    }
    
    func hasPreviousUser(currentUserId: Int) -> Bool {
        if let currentUserIndex = currentUserIndex(id: currentUserId),
            currentUserIndex > 0 {
            return true
        }
        return false
    }
    
    func hasNextUser(currentUserId: Int) -> Bool {
        if let currentUserIndex = currentUserIndex(id: currentUserId),
           currentUserIndex < users.count - 1 {
            return true
        }
        return false
    }
    
    private func currentUserIndex(id: Int) -> Int? {
        users.firstIndex(where: { $0.id == id })
    }
    
    private func readData()  throws(DataError) -> Pages {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            throw .noData
        }

        guard let data = try? Data(contentsOf: url) else {
            throw .loadingFailed
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let pages = try? decoder.decode(Pages.self, from: data) else {
            throw .decodingFailed
        }
        return pages
    }
}

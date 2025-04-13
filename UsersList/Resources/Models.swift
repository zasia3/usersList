//
//  Models.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import Foundation

struct Pages: Decodable {
    let pages: [Page]
}

struct Page: Decodable {
    let users: [User]
}

struct User: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let profilePictureUrl: String
    
    init(id: Int, name: String, profilePictureUrl: String) {
        self.id = id
        self.name = name
        self.profilePictureUrl = profilePictureUrl 
    }
    
    init(user: User, idOffset: Int) {
        id = user.id + idOffset
        name = user.name
        profilePictureUrl = user.profilePictureUrl
    }
}

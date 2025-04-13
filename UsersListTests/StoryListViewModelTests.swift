//
//  UsersListTests.swift
//  UsersListTests
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import XCTest
@testable import UsersList

final class StoryListViewModelTests: XCTestCase {
    var sut: StoryListViewModel!
    var mockStoryHandler: MockStoryHandler!
    var mockDataProvider: MockDataProvider!

    override func setUpWithError() throws {
        mockStoryHandler = MockStoryHandler()
        mockDataProvider = MockDataProvider()
        sut = StoryListViewModel(dataProvider: mockDataProvider, storyHandler: mockStoryHandler)
    }

    func testErrorOnNoData() throws {
        sut.fetchStoryList()
        
        XCTAssertNotNil(sut.error)
        XCTAssertNil(sut.pages)
    }
    
    func testSuccessfulFetchData() throws {
        let user = User(id: 1, name: "John", profilePictureUrl: "example.com")
        let page = Page(users: [user])
        mockDataProvider.pagesToReturn = Pages(pages: [page])
        sut.fetchStoryList()
        
        XCTAssertNotNil(sut.pages)
    }
    
    override func tearDown() {
        mockStoryHandler = nil
        mockDataProvider = nil
        sut = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

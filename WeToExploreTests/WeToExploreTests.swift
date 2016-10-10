//
//  WeToExploreTests.swift
//  WeToExploreTests
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import XCTest
@testable import WeToExplore

class WeToExploreTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testWEDataManager() {
        WEDataManager.getHTML { response in
            XCTAssertNil(response, "failed to get HTML")
            let htmlstring = String(data: response, encoding: NSUnicodeStringEncoding)
            XCTAssertNil(htmlstring, "Failed to get HTML")
        }
        
        WEDataManager.getJSON { response in
            XCTAssertNil(response, "Failed to get JSON")
        }
        
        WEDataManager.getJSON("api/topics/hot.json", parameters: nil) { response in
            XCTAssertNil(response, "Failed to get JSON")
        }
    }
    
    func testWENodeModel() {
        WENodeModel.getNode(true)
        { nodeGroupArray in
            XCTAssertNil(nodeGroupArray, "Failed to get nodeGroup")
        }
    }
    
    func testWETopicListViewModel() {
        let topicListMode = WETopicListViewModel()
        topicListMode.showTopics("all")
        XCTAssertNil(topicListMode.topics)
    }
}

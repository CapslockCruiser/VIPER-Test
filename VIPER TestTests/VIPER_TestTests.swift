//
//  VIPER_TestTests.swift
//  VIPER TestTests
//
//  Created by William Choi on 6/9/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import XCTest
@testable import VIPER_Test

class VIPER_TestTests: XCTestCase {
    
    var dataManager: DataManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataManager = DataManager(environment: .development)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataManager = nil
        super.tearDown()
    }
    
    func testDataManager() {
        var achievements: [Achievement] = []
        let promise = expectation(description: "Achievements retrieved")
        
        dataManager.retrieveAchievements() { retrievedAchievements in
            achievements = retrievedAchievements
            assert(achievements.count == 3)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
}

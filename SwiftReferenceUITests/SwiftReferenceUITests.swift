//
//  SwiftReferenceUITests.swift
//  SwiftReferenceUITests
//
//  Created by wooky83 on 2017. 10. 18..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import XCTest

class SwiftReferenceUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["RxExample(UIButton, UITextField)"]/*[[".cells.staticTexts[\"RxExample(UIButton, UITextField)\"]",".staticTexts[\"RxExample(UIButton, UITextField)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["RxCoCoa"].buttons["Swift Reference"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

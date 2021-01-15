//
//  PassboltTimer.swift
//  Passbolt POCTests
//
//  Created by Maciej Gąsiorowski on 14/01/2021.
//

import XCTest
@testable import Passbolt_POC

class PassboltTimerTests: XCTestCase {
    
    var passboltTimer: PassboltTimer!
    
    override func setUp() {
        super.setUp()
        
        passboltTimer = PassboltTimer()
    }
    
    override func tearDown() {
        super.tearDown()
        
        passboltTimer = nil
    }
    
    func testPassboltTimerNotNilAfterStart() {
        passboltTimer.start()
        XCTAssertNotNil(passboltTimer.stopAndReturnDuration())
    }
    
    func testPassboltTimerReturnMinusOneWithoutStart() {
        XCTAssertEqual(passboltTimer.stopAndReturnDuration(), -1)
    }
}

import XCTest

class BaseScreen {
    
    let waitTimeout: Double = 10
    
    func checkIfElementExists(_ element: XCUIElement) {
        XCTAssert(element.waitForExistence(timeout: waitTimeout), "Element \(element.description) does not exist")
    }
    
    func tapElement(_ element: XCUIElement) {
        waitForElementToBeHittable(element: element)
        element.tap()
    }
    
    func waitForElementToBeHittable(element: XCUIElement, timeout time: Double = 10) {
         let predicate = NSPredicate(format: "isHittable = true")
         let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
         let result = XCTWaiter.wait(for: [expectation], timeout: time)
         guard result == .completed else {
             XCTFail("Element '\(element)' is not hittable")
             return
         }
    }
}

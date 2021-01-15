import XCTest

class BaseTest: XCTestCase {
    let app = XCUIApplication()
    
    func launchApplication() {
        app.launch()
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        launchApplication()
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
}

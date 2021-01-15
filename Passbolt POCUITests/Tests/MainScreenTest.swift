class MainScreenTest: BaseTest {
    
    let mainScreen: MainScreen = MainScreen()
    
    func testActionBarDisplayed() {
        mainScreen.checkIfNavigationBarDisplayed()
    }
}

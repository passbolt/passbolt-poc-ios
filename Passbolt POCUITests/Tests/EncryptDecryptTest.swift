class EncryptDecryptTest: BaseTest {
    
    let mainScreen: MainScreen = MainScreen()
    let encryptionLibraryScreen: EncryptionLibraryScreen = EncryptionLibraryScreen()
    let encryptDecryptScreen: EncryptDecryptScreen = EncryptDecryptScreen()
    
    func testMessageEditTextDisplayed() {
        mainScreen.tapEncryptionLibraryMilestone()
        encryptionLibraryScreen.tapEncryptDecryptCell()
        encryptDecryptScreen.checkIfMessageInputDisplayed()
    }
    
    func testKeyEditTextDisplayed() {
        mainScreen.tapEncryptionLibraryMilestone()
        encryptionLibraryScreen.tapEncryptDecryptCell()
        encryptDecryptScreen.checkIfKeyInputDisplayed()
    }
}

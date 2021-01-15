import XCTest

class EncryptDecryptScreen: BaseScreen {

    private enum Elements: String {
        case messageTextView = "message_text_view"
        case keyTextView = "key_text_view"
        
        var elementType: XCUIElement {
            switch self {
                case .messageTextView,
                     .keyTextView:
                    return XCUIApplication().textViews[self.rawValue]
            }
        }
    }
        
    func checkIfMessageInputDisplayed() {
        checkIfElementExists(Elements.messageTextView.elementType)
    }
    
    func checkIfKeyInputDisplayed() {
        checkIfElementExists(Elements.keyTextView.elementType)
    }
}

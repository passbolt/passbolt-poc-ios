import XCTest

class MainScreen: BaseScreen {

    private enum Elements: String {
        case milestoneTableCellEncryptionLibrary = "milestone_table_cell_encryption_library_poc"
        case navigationBar = "scene_navigation_bar"
        
        var elementType: XCUIElement {
            switch self {
                case .navigationBar:
                    return XCUIApplication().navigationBars[self.rawValue]
            case .milestoneTableCellEncryptionLibrary:
                return XCUIApplication().cells[self.rawValue]
            }
        }
    }
        
    func checkIfNavigationBarDisplayed() {
        checkIfElementExists(Elements.navigationBar.elementType)
    }
    
    func tapEncryptionLibraryMilestone() {
        tapElement(Elements.milestoneTableCellEncryptionLibrary.elementType)
    }
}

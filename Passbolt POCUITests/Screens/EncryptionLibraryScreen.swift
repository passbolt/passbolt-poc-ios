import XCTest

class EncryptionLibraryScreen: BaseScreen {

    private enum Elements: String {
        case encryptionLibraryTableCellEncryptDecrypt = "encryption_library_table_cell_encrypt_decrypt_poc"
        
        var elementType: XCUIElement {
            switch self {
                case .encryptionLibraryTableCellEncryptDecrypt:
                    return XCUIApplication().cells[self.rawValue]
            }
        }
    }
        
    func tapEncryptDecryptCell() {
        tapElement(Elements.encryptionLibraryTableCellEncryptDecrypt.elementType)
    }
}

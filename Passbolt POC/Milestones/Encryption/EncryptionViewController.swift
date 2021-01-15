import UIKit

private enum EncryptionFeature: String, CaseIterable {
    case encryptDecrypt = "Encrypt/Decrypt POC"
    case signVerify = "Sign/Verify POC"
}

class EncryptionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = PassboltStrings.Encrypt.title

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EncryptionFeature.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        // Configure the cell...
        let cellText = EncryptionFeature.allCases[indexPath.row].rawValue
        cell.textLabel?.text = cellText
        cell.accessibilityIdentifier = AccessibilityIdentifiers.EncryptionLibrary.encryptionFeatureTableCell + cellText.lowercased().replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "/", with: "_")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = EncryptionFeature.allCases[indexPath.row]

        let controller: UIViewController
        switch feature {
        case .encryptDecrypt:
            controller = EncryptDecryptViewController()
        case .signVerify:
            controller = SignVerifyViewController()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

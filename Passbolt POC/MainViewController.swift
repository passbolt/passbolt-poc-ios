//
//  MainViewController.swift
//  Passbolt POC
//
//  Created by Wojciech Piwoński on 12/3/20.
//

import UIKit
import AuthenticationServices

private enum Milestone: String, CaseIterable {
    case encryption = "Encryption library POC"
    case autofill = "Autofill POC"
    case setup = "Setup POC"
    case secureStorage = "Secure storage POC"
}

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = PassboltStrings.Main.title

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")

        ASCredentialIdentityStore.shared.getState { state in
            if state.isEnabled {
                let provider = AutofillCredentialIdentitiesProvider()
                ASCredentialIdentityStore.shared.saveCredentialIdentities(provider.provideCredentialIdentities())
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Milestone.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        // Configure the cell...
        let cellText = Milestone.allCases[indexPath.row].rawValue
        cell.textLabel?.text = cellText
        cell.accessibilityIdentifier = AccessibilityIdentifiers.MainView.milestoneTableCell + cellText.lowercased().replacingOccurrences(of: " ", with: "_")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let milestone = Milestone.allCases[indexPath.row]

        let controller: UIViewController
        switch milestone {
        case .encryption:
            controller = EncryptionViewController()
        case .autofill:
            controller = AutofillTestViewController()
        case .setup:
            return
        case .secureStorage:
            controller = SecureStorageViewController()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

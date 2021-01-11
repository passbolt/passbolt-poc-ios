import UIKit
import AuthenticationServices

class AutofillTestViewController: UIViewController {

    var customView: AutofillTestView {
        return view as! AutofillTestView
    }

    override func loadView() {
        view = AutofillTestView()
        self.title = PassboltStrings.AutofillTest.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.checkAutoFillStatusButton.addTarget(
            self, action: #selector(checkAutoFillStatusButtonClicked), for: .touchUpInside
        )
        customView.openAppleWebsiteButton.addTarget(
            self, action: #selector(openAppleWebsiteButtonClicked), for: .touchUpInside
        )
        customView.openStravaAppButton.addTarget(self, action: #selector(openStravaAppButtonClicked), for: .touchUpInside)
    }

    @objc func checkAutoFillStatusButtonClicked() {
        ASCredentialIdentityStore.shared.getState { state in
            if state.isEnabled {
                DispatchQueue.main.async { [weak self] in
                    self?.showToast(message: "AutoFill enabled")
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.showToast(message: "AutoFill disabled, go to Settings")
                }
            }
        }
    }

    @objc func openAppleWebsiteButtonClicked() {
        guard let url = URL(string: "https://apple.com") else { return }
        UIApplication.shared.open(url)
    }

    @objc func openStravaAppButtonClicked() {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/id426826309") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

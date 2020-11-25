import Foundation
import UIKit

class MainView: UIView {

    let label: UILabel

    init() {
        self.label = UILabel()
        self.label.text = "Passbolt POC"
        super.init(frame: .zero)
        self.backgroundColor = .yellow
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

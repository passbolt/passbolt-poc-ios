import Foundation
import UIKit
import SnapKit

class MainView: UIView {

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Passbolt POC"
        return label
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        addSubviews(label)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

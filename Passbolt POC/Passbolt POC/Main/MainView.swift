import Foundation
import UIKit
import SnapKit

class MainView: UIView {

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.systemBackground
        addSubviews(label)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setLabelText(text: String) {
        label.text = text
    }

    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges).inset(16)
        }
    }
}

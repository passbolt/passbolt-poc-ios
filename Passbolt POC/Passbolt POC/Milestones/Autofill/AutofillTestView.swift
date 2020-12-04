import UIKit
import SnapKit

class AutofillTestView: UIView {

    lazy var checkAutoFillStatusButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.AutofillTest.checkAutoFillStatusButton, for: .normal)
        return button
    }()

    lazy var openAppleWebsiteButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.AutofillTest.openAppleWebsiteButton, for: .normal)
        return button
    }()

    lazy var openStravaAppButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.AutofillTest.openStravaApp, for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.systemBackground

        addSubviews(checkAutoFillStatusButton, openAppleWebsiteButton, openStravaAppButton)

        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        checkAutoFillStatusButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.centerX.equalToSuperview()
        }

        openAppleWebsiteButton.snp.makeConstraints {
            $0.top.equalTo(checkAutoFillStatusButton.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }

        openStravaAppButton.snp.makeConstraints {
            $0.top.equalTo(openAppleWebsiteButton.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }
    }
}

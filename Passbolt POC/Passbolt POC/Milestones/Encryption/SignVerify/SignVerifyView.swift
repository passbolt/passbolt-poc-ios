import Foundation
import UIKit
import SnapKit

class SignVerifyView: UIView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()

    private lazy var scrollViewContent = UIView()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.messageLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = UIColor.label
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    private lazy var keysInfoLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.keysInfoLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var useFirstKeyLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.useFirstKeyLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    var keySwitch = UISwitch()

    private lazy var useSecondKeyLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.useSecondKeyLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var privateKeyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SignVerify.privateKeyButton, for: .normal)
        return button
    }()

    lazy var publicKeyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SignVerify.publicKeyButton, for: .normal)
        return button
    }()

    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.keyLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var keyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = UIColor.label
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.passwordLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var passwordTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = UIColor.label
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.returnKeyType = .done
        return textView
    }()

    lazy var signButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SignVerify.signButton, for: .normal)
        return button
    }()

    lazy var verifyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SignVerify.verifyButton, for: .normal)
        return button
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SignVerify.resultLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var resultTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = UIColor.label
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.returnKeyType = .done
        return textView
    }()

    private var contentTopConstraint: Constraint?
    private var contentBottomConstraint: Constraint?

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.systemBackground

        addSubviews(scrollView)
        scrollView.addSubview(scrollViewContent)

        scrollViewContent.addSubviews(messageLabel, messageTextView, keysInfoLabel, useFirstKeyLabel, keySwitch,
        useSecondKeyLabel, privateKeyButton, publicKeyButton, keyLabel, keyTextView, passwordLabel, passwordTextView,
            signButton, verifyButton, resultLabel, resultTextView)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateKeyboardConstraints(keyboardHeight: CGFloat) {
        if keyboardHeight == .zero {
            contentTopConstraint?.update(offset: 0)
            contentBottomConstraint?.update(offset: 0)
        } else {
            contentTopConstraint?.update(offset: -40)
            contentBottomConstraint?.update(offset: -keyboardHeight + 40)
        }
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            contentTopConstraint = $0.top.equalTo(safeAreaLayoutGuide.snp.top).constraint
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            contentBottomConstraint = $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).constraint
        }

        scrollViewContent.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
            $0.leading.trailing.equalToSuperview().priority(.required)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        messageTextView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }

        keysInfoLabel.snp.makeConstraints {
            $0.top.equalTo(messageTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        keySwitch.snp.makeConstraints {
            $0.top.equalTo(keysInfoLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        useFirstKeyLabel.snp.makeConstraints {
            $0.centerY.equalTo(keySwitch.snp.centerY)
            $0.trailing.equalTo(keySwitch.snp.leading).offset(-8)
        }

        useSecondKeyLabel.snp.makeConstraints {
            $0.centerY.equalTo(keySwitch.snp.centerY)
            $0.leading.equalTo(keySwitch.snp.trailing).offset(8)
        }

        privateKeyButton.snp.makeConstraints {
            $0.top.equalTo(keySwitch.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(64)
        }

        publicKeyButton.snp.makeConstraints {
            $0.top.equalTo(privateKeyButton.snp.top)
            $0.trailing.equalToSuperview().inset(64)
        }

        keyLabel.snp.makeConstraints {
            $0.top.equalTo(privateKeyButton.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        keyTextView.snp.makeConstraints {
            $0.top.equalTo(keyLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(300)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(keyTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        passwordTextView.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        signButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(64)
        }

        verifyButton.snp.makeConstraints {
            $0.top.equalTo(signButton.snp.top)
            $0.trailing.equalToSuperview().inset(64)
        }

        resultLabel.snp.makeConstraints {
            $0.top.equalTo(signButton.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        resultTextView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(300)
            $0.bottom.equalToSuperview().inset(192)
        }
    }
}

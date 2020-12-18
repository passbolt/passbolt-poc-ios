import UIKit
import SnapKit

class SecureStorageView: UIView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()

    private lazy var scrollViewContent = UIView()

    lazy var useFirstKeyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.useFirstKeyButton, for: .normal)
        return button
    }()

    lazy var useSecondKeyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.useSecondKeyButton, for: .normal)
        return button
    }()

    private lazy var publicKeyLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SecureStorage.publicKeyLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var publicKeyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = UIColor.label
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    private lazy var privateKeyLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SecureStorage.privateKeyLabel
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var privateKeyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = UIColor.label
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = PassboltStrings.SecureStorage.passwordLabel
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

    lazy var clearUIButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.clearUI, for: .normal)
        return button
    }()

    lazy var readKeysButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.readKeysButton, for: .normal)
        return button
    }()

    lazy var saveKeysButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.saveKeysButton, for: .normal)
        return button
    }()

    lazy var clearStorageButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.clearStorageButton, for: .normal)
        return button
    }()

    lazy var saveToKeychainButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.saveToKeychainButton, for: .normal)
        return button
    }()

    lazy var readFromKeychainButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.readFromKeychainButton, for: .normal)
        return button
    }()

    lazy var deleteFromKeychainButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.deleteFromKeychainButton, for: .normal)
        return button
    }()

    lazy var createKeyInSE: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.encryptDataButton, for: .normal)
        return button
    }()

    lazy var createKeyInSEButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.createKeyInSE, for: .normal)
        return button
    }()

    lazy var loadKeyFromSEButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.loadKeyFromSE, for: .normal)
        return button
    }()

    lazy var deleteKeyFromSEButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.deleteKeyFromSE, for: .normal)
        return button
    }()

    lazy var decryptDataButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.decryptDataButton, for: .normal)
        return button
    }()

    lazy var encryptDataButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.titleLabel?.font = button.titleLabel?.font.withSize(18)
        button.setTitle(PassboltStrings.SecureStorage.encryptDataButton, for: .normal)
        return button
    }()

    private var contentTopConstraint: Constraint?
    private var contentBottomConstraint: Constraint?

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.systemBackground

        addSubviews(scrollView)
        scrollView.addSubview(scrollViewContent)

        scrollViewContent.addSubviews(useFirstKeyButton, useSecondKeyButton, publicKeyLabel, publicKeyTextView,
            privateKeyLabel, privateKeyTextView, passwordLabel, passwordTextView,
            clearUIButton, readKeysButton, saveKeysButton, clearStorageButton/*,
            saveToKeychainButton, readFromKeychainButton, deleteFromKeychainButton,
            createKeyInSEButton, loadKeyFromSEButton, deleteKeyFromSEButton, encryptDataButton, decryptDataButton*/)

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

        useFirstKeyButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(64)
        }

        useSecondKeyButton.snp.makeConstraints {
            $0.top.equalTo(useFirstKeyButton.snp.top)
            $0.trailing.equalToSuperview().inset(64)
        }

        publicKeyLabel.snp.makeConstraints {
            $0.top.equalTo(useSecondKeyButton.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        publicKeyTextView.snp.makeConstraints {
            $0.top.equalTo(publicKeyLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }

        privateKeyLabel.snp.makeConstraints {
            $0.top.equalTo(publicKeyTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        privateKeyTextView.snp.makeConstraints {
            $0.top.equalTo(privateKeyLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(privateKeyTextView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        passwordTextView.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        clearUIButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }

        readKeysButton.snp.makeConstraints {
            $0.top.equalTo(clearUIButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }

        saveKeysButton.snp.makeConstraints {
            $0.top.equalTo(readKeysButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }

        clearStorageButton.snp.makeConstraints {
            $0.top.equalTo(saveKeysButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(64)
        }

//        saveToKeychainButton.snp.makeConstraints {
//            $0.top.equalTo(clearStorageButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
//        }
//
//        readFromKeychainButton.snp.makeConstraints {
//            $0.top.equalTo(saveToKeychainButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
//        }
//
//        deleteFromKeychainButton.snp.makeConstraints {
//            $0.top.equalTo(readFromKeychainButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
//        }
//
//        createKeyInSEButton.snp.makeConstraints {
//            $0.top.equalTo(deleteFromKeychainButton.snp.bottom).offset(128)
//            $0.centerX.equalToSuperview()
//        }
//
//        loadKeyFromSEButton.snp.makeConstraints {
//            $0.top.equalTo(createKeyInSEButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
//        }
//
//        deleteKeyFromSEButton.snp.makeConstraints {
//            $0.top.equalTo(loadKeyFromSEButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
//        }
//
//        encryptDataButton.snp.makeConstraints {
//            $0.top.equalTo(deleteKeyFromSEButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
//        }
//
//        decryptDataButton.snp.makeConstraints {
//            $0.top.equalTo(encryptDataButton.snp.bottom).offset(64)
//            $0.centerX.equalToSuperview()
////            $0.bottom.equalToSuperview().inset(128)
//        }
    }
}

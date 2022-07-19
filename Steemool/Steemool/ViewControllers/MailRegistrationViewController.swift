//
//  MailRegistrationViewController.swift
//  Steemool
//
//  Created by Ekaterina Nedelko on 18.07.22.
//

import UIKit
import SnapKit

class MailRegistrationViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var hidePassword = true
    
    // MARK: - Views
    
    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont(name: "SFProText-Semibold", size: CGFloat(17).adaptedFontSize)
        userNameLabel.text = "Имя"
        
        return userNameLabel
    }()
    
    private lazy var userNameTextField: UserAuthorizationDataTextField = {
        let userNameTextField = UserAuthorizationDataTextField()
        userNameTextField.placeholder = "Ваше имя"
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 9.HAdapted, height: 0))
        userNameTextField.leftView = paddingView
        userNameTextField.leftViewMode = .always
        
        userNameTextField.addTarget(self, action: #selector(userNameTextFieldDidChange), for: .editingChanged)
        
        return userNameTextField
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = UIFont(name: "SFProText-Semibold", size: CGFloat(17).adaptedFontSize)
        emailLabel.text = "Email"
        
        return emailLabel
    }()
    
    private lazy var emailTextField: UserAuthorizationDataTextField = {
        let emailTextField = UserAuthorizationDataTextField()
        emailTextField.placeholder = "Введите адрес электронной почты"
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 9.HAdapted, height: 0))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        
        return emailTextField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.font = UIFont(name: "SFProText-Semibold", size: CGFloat(17).adaptedFontSize)
        passwordLabel.text = "Пароль"
        
        return passwordLabel
    }()
    
    private lazy var passwordTextField: UserAuthorizationDataTextField = {
        let passwordTextField = UserAuthorizationDataTextField()
        passwordTextField.placeholder = "Введите пароль"
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 9.HAdapted, height: 0))
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
        
        let showPasswordButton = UIButton(type: .custom)
        showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        showPasswordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        showPasswordButton.frame = CGRect(x: -10, y: 0, width: CGFloat(17.HAdapted), height: CGFloat(17.HAdapted))
        showPasswordButton.addTarget(self, action: #selector(self.toggleShowPasswordButtonView), for: .touchUpInside)
        showPasswordButton.contentMode = .center
        
        passwordTextField.rightView = showPasswordButton
        passwordTextField.rightViewMode = .always

        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        return passwordTextField
    }()
    
    private lazy var helpLabel: UILabel = {
        let helpLabel = UILabel()
        helpLabel.text = "Введите не менее 8 символов"
        helpLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        helpLabel.font = UIFont(name: "SFPro-Regular", size: CGFloat(13).adaptedFontSize)
        helpLabel.textAlignment = .left
        
        return helpLabel
    }()
    
    private lazy var logInButton: LogInButton = {
        let logInButton = LogInButton()
        logInButton.setTitle("Зарегистрироваться", for: .normal)
        logInButton.makeInactive()
        
        logInButton.addTarget(self, action: #selector(handleLogInButtonTouch), for: .touchUpInside)
        
        return logInButton
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        setupAppearance()
        addSubviews()
        configureLayout()
    }
}

// MARK: - Appearance Methods

private extension MailRegistrationViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .customPurple
        navigationItem.title = "Регистрация"
        
        let button: UIButton = UIButton(type: .custom)
        button.tintColor = .customPurple
        button.setTitleColor(.customPurple, for: .normal)
        
        button.contentMode = .left
        button.semanticContentAttribute = .forceLeftToRight
        
        let fullString = NSMutableAttributedString(string: "")

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "chevron.left")?.withTintColor(.customPurple)

        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " Назад"))
        
        button.setAttributedTitle(fullString, for: .normal)
    
        button.addTarget(self, action: #selector(handleLeftBarButtonItemTouch), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setupAppearance() {
        view.backgroundColor = .backgroundColor
    }
    
    func addSubviews() {
        view.addSubview(userNameLabel)
        view.addSubview(userNameTextField)
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        
        view.addSubview(helpLabel)
        
        view.addSubview(logInButton)
    }
    
    func configureLayout() {
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalToSuperview().offset(112.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(22.VAdapted)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalToSuperview().offset(142.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(userNameTextField.snp.bottom).offset(16.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(22.VAdapted)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(userNameTextField.snp.bottom).offset(46.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(emailTextField.snp.bottom).offset(16.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(22.VAdapted)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(emailTextField.snp.bottom).offset(46.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
        
        helpLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(passwordTextField.snp.bottom).offset(4.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(18.VAdapted)
        }
        
        logInButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.bottom.equalToSuperview().offset(-42.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
    }
    
    func checkLogInButtonAccessibility() {
        guard let userName = userNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if userName.isEmpty || email.isEmpty || password.isEmpty {
            logInButton.makeInactive()
            return
        }
        
        logInButton.makeActive()
    }
}

// MARK: - Actions

private extension MailRegistrationViewController {
    @objc private func toggleShowPasswordButtonView(_ sender: UIButton) {
        hidePassword = !hidePassword
        passwordTextField.isSecureTextEntry = hidePassword
        sender.setImage(UIImage(systemName: hidePassword ? "eye.slash" : "eye") ?? UIImage(), for: .normal)
    }
    
    @objc func handleLeftBarButtonItemTouch() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func userNameTextFieldDidChange(_ textField: UITextField) {
        checkLogInButtonAccessibility()
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        checkLogInButtonAccessibility()
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        checkLogInButtonAccessibility()
    }
}

// MARK: - Private Methods

private extension MailRegistrationViewController {
    @objc func handleLogInButtonTouch(_ sender: UIButton) {
        print("registration")
    }
}

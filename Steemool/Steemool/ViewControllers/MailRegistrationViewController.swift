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
    
    private var showPassword = false
    
    // MARK: - Views
    
    private lazy var userNameTextField: UserAuthorizationDataTextField = {
        let userNameTextField = UserAuthorizationDataTextField()
        userNameTextField.placeholder = "Ваше имя"
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 9.HAdapted, height: 0))
        userNameTextField.leftView = paddingView
        userNameTextField.leftViewMode = .always
        
        return userNameTextField
    }()
    
    private lazy var emailTextField: UserAuthorizationDataTextField = {
        let emailTextField = UserAuthorizationDataTextField()
        emailTextField.placeholder = "Введите адрес электронной почты"
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 9.HAdapted, height: 0))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        return emailTextField
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
    
        let leftBarButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func toggleShowPasswordButtonView(_ sender: UIButton) {
        showPassword = !showPassword
        passwordTextField.isSecureTextEntry = showPassword
        sender.setImage(UIImage(systemName: showPassword ? "eye" : "eye.slash") ?? UIImage(), for: .normal)
    }
    
    func setupAppearance() {
        view.backgroundColor = .backgroundColor
    }
    
    func addSubviews() {
        view.addSubview(userNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        view.addSubview(helpLabel)
        
        view.addSubview(logInButton)
    }
    
    func configureLayout() {
        userNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(112.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalTo(userNameTextField.snp.bottom).offset(46.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-29.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
    }
}



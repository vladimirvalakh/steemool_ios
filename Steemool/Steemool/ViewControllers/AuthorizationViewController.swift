//
//  AuthorizationViewController.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit
import SnapKit

class AuthorizationViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var showPassword = false
    
    // MARK: - Views
    
    private lazy var emailTextField: UserAuthorizationDataTextField = {
        let emailTextField = UserAuthorizationDataTextField()
        emailTextField.placeholder = "Email"
        
        let emailView = UIView(frame: CGRect(x: 0, y: 0, width: 33.HAdapted, height: 22.HAdapted))
        let emailImageView = UIImageView(image: UIImage(systemName: "person"))
        emailImageView.frame = CGRect(x: 10, y: 0, width: 19.HAdapted, height: 22.HAdapted)
        emailImageView.contentMode = .scaleAspectFit
        emailView.addSubview(emailImageView)

        emailTextField.leftView = emailView
        emailTextField.leftViewMode = .always
        
        return emailTextField
    }()
    
    private lazy var passwordTextField: UserAuthorizationDataTextField = {
        let passwordTextField = UserAuthorizationDataTextField()
        passwordTextField.placeholder = "Пароль"

        let passwordView = UIView(frame: CGRect(x: 0, y: 0, width: 33.HAdapted, height: 22.HAdapted))
        let passwordImageView = UIImageView(image: UIImage(systemName: "lock"))
        passwordImageView.frame = CGRect(x: 10, y: 0, width: 19.HAdapted, height: 22.HAdapted)
        passwordImageView.contentMode = .scaleAspectFit
        passwordView.addSubview(passwordImageView)

        passwordTextField.leftView = passwordView
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
        helpLabel.text = "Забыли пароль?"
        helpLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        helpLabel.font = UIFont(name: "SFPro-Regular", size: CGFloat(13).adaptedFontSize)
        helpLabel.textAlignment = .right
        
        return helpLabel
    }()
    
    private lazy var actionButtonsStackView: UIStackView = {
        let actionButtonsStackView = UIStackView()
        actionButtonsStackView.axis = .vertical
        actionButtonsStackView.distribution = .fillEqually
        actionButtonsStackView.spacing = 8.VAdapted
        
        return actionButtonsStackView
    }()
    
    private lazy var signInButton: LogInButton = {
        let signInButton = LogInButton()
        signInButton.setTitle("Войти", for: .normal)
        signInButton.makeActive()
        
        return signInButton
    }()
    
    private lazy var logInButton: LogInButton = {
        let logInButton = LogInButton()
        logInButton.setTitle("Зарегистрироваться", for: .normal)
        
        logInButton.addTarget(self, action: #selector(handleLogInButtonTouch), for: .touchUpInside)
        
        return logInButton
    }()
    
    private var continueWithAppleHandleButton: ContinueWithAccountButton = {
        let continueWithAppleHandleButton = ContinueWithAccountButton()
        continueWithAppleHandleButton.setTitle("Войти через Apple", for: .normal)
        continueWithAppleHandleButton.setImage(UIImage(systemName: "applelogo"), for: .normal)
        
        return continueWithAppleHandleButton
    }()
    
    private var continueWithGoogleHandleButton: ContinueWithAccountButton = {
        let continueWithGoogleHandleButton = ContinueWithAccountButton()
        continueWithGoogleHandleButton.setTitle("Войти через Google", for: .normal)
        continueWithGoogleHandleButton.setImage( UIImage(named: "googlelogo")?.resizedImage(Size: CGSize(width: 22.HAdapted, height: 22.HAdapted)), for: .normal)
        
        return continueWithGoogleHandleButton
    }()
    
    private var continueWithFacebookHandleButton: ContinueWithAccountButton = {
        let continueWithFacebookHandleButton = ContinueWithAccountButton()
        continueWithFacebookHandleButton.setTitle("Войти через Facebook", for: .normal)
        continueWithFacebookHandleButton.setImage( UIImage(named: "facebooklogo")?.resizedImage(Size: CGSize(width: 18.HAdapted, height: 18.HAdapted)), for: .normal)
        
        return continueWithFacebookHandleButton
    }()
    
    private var continueWithVKHandleButton: ContinueWithAccountButton = {
        let continueWithVKHandleButton = ContinueWithAccountButton()
        continueWithVKHandleButton.setTitle("Войти через VK", for: .normal)
        continueWithVKHandleButton.setImage( UIImage(named: "vklogo")?.resizedImage(Size: CGSize(width: 18.HAdapted, height: 18.HAdapted)), for: .normal)
        
        return continueWithVKHandleButton
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

private extension AuthorizationViewController {
   private func setupNavigationBar() {
        let button: UIButton = UIButton(type: .custom)
        
        button.tintColor = .customPurple
        button.setTitleColor(.customPurple, for: .normal)
        
       let fullString = NSMutableAttributedString(string: "Пропустить ")
       
       let imageAttachment = NSTextAttachment()
       imageAttachment.image = UIImage(systemName: "chevron.right")?.withTintColor(.customPurple)
       
       let imageString = NSAttributedString(attachment: imageAttachment)
       
       fullString.append(imageString)
       
       button.setAttributedTitle(fullString, for: .normal)
       
       let rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
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
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        view.addSubview(helpLabel)
        
        view.addSubview(actionButtonsStackView)
        
        actionButtonsStackView.addArrangedSubview(signInButton)
        actionButtonsStackView.addArrangedSubview(logInButton)
        
        actionButtonsStackView.addArrangedSubview(continueWithAppleHandleButton)
        actionButtonsStackView.addArrangedSubview(continueWithGoogleHandleButton)
        actionButtonsStackView.addArrangedSubview(continueWithFacebookHandleButton)
        actionButtonsStackView.addArrangedSubview(continueWithVKHandleButton)
    }
    
    func configureLayout() {
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalToSuperview().offset(112.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalToSuperview().offset(180.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(52.VAdapted)
        }
        
        helpLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.top.equalToSuperview().offset(236.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(22.VAdapted)
        }
        
        actionButtonsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.bottom.equalToSuperview().offset(-210.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(352.VAdapted)
        }
    }
}

// MARK: - Actions

private extension AuthorizationViewController {
    @objc func handleLogInButtonTouch() {
        self.navigationController?.pushViewController(MailRegistrationViewController(), animated: true)
    }
}


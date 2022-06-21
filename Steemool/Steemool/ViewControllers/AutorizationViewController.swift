//
//  AutorizationViewController.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit
import SnapKit

class AutorizationViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var showPassword = false
    
    private var emailTextField = UserAutorizationDataTextField()
    private var passwordTextField = UserAutorizationDataTextField()
    
    private var helpLabel = UILabel()
    
    private var actionButtonsStackView: UIStackView = {
        let actionButtonsStackView = UIStackView()
        actionButtonsStackView.axis = .vertical
        actionButtonsStackView.distribution = .fillEqually
        actionButtonsStackView.spacing = 8.VAdapted
        
        return actionButtonsStackView
    }()
    
    private let signInHandleButton = LogInButton()
    private let logInHandleButton = LogInButton()
    
    private var continueWithAppleHandleButton = ContinueWithAccountButton()
    private var continueWithGoogleHandleButton = ContinueWithAccountButton()
    private var continueWithFacebookHandleButton = ContinueWithAccountButton()
    private var continueWithVKHandleButton = ContinueWithAccountButton()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        setupAppearance()
        addSubviews()
        configureLayout()
    }
}

// MARK: - Appearance Methods

private extension AutorizationViewController {
    private func setupView() {
        setupNavigationBar()
        
        setupTextFields()
        setupHelpLabel()
        
        setupActionButtons()
    }
    
    private func setupNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.title = "Пропустить >"
        rightBarButtonItem.tintColor = UIColor(red: 0.639, green: 0.416, blue: 0.98, alpha: 1)
        
        if let font = UIFont(name: "SFProText-Regular", size: 17) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupTextFields() {
        emailTextField.placeholder = "Email"
        
        let emailView = UIView(frame: CGRect(x: 0, y: 0, width: 33.HAdapted, height: 22.HAdapted))
        let emailImageView = UIImageView(image: UIImage(systemName: "person"))
        emailImageView.frame = CGRect(x: 10, y: 0, width: 19.HAdapted, height: 22.HAdapted)
        emailImageView.contentMode = .scaleAspectFit
        emailView.addSubview(emailImageView)

        emailTextField.leftView = emailView
        emailTextField.leftViewMode = .always
        
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
    }
    
    @objc private func toggleShowPasswordButtonView(_ sender: UIButton) {
        showPassword = !showPassword
        passwordTextField.isSecureTextEntry = showPassword
        sender.setImage(UIImage(systemName: showPassword ? "eye" : "eye.slash") ?? UIImage(), for: .normal)
    }
    
    private func setupHelpLabel() {
        helpLabel.text = "Забыли пароль?"
        helpLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        helpLabel.font = UIFont(name: "SFPro-Regular", size: 13)
        helpLabel.textAlignment = .right
    }
    
    private func setupActionButtons() {
        signInHandleButton.setTitle("Войти", for: .normal)
        logInHandleButton.setTitle("Зарегистрироваться", for: .normal)
        
        continueWithAppleHandleButton.setTitle("Войти через Apple", for: .normal)
        continueWithAppleHandleButton.setImage(UIImage(systemName: "applelogo"), for: .normal)
        
        continueWithGoogleHandleButton.setTitle("Войти через Google", for: .normal)
        continueWithGoogleHandleButton.setImage( UIImage(named: "googlelogo")?.resizedImage(Size: CGSize(width: 22.HAdapted, height: 22.HAdapted)), for: .normal)

        continueWithFacebookHandleButton.setTitle("Войти через Facebook", for: .normal)
        continueWithFacebookHandleButton.setImage( UIImage(named: "facebooklogo")?.resizedImage(Size: CGSize(width: 18.HAdapted, height: 18.HAdapted)), for: .normal)
        
        continueWithVKHandleButton.setTitle("Войти через VK", for: .normal)
        continueWithVKHandleButton.setImage( UIImage(named: "vklogo")?.resizedImage(Size: CGSize(width: 18.HAdapted, height: 18.HAdapted)), for: .normal)
    }
    
    func setupAppearance() {
        view.backgroundColor = UIColor(red: 0.815, green: 0.815, blue: 0.815, alpha: 1)
    }
    
    func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        view.addSubview(helpLabel)
        
        view.addSubview(actionButtonsStackView)
        
        actionButtonsStackView.addArrangedSubview(signInHandleButton)
        actionButtonsStackView.addArrangedSubview(logInHandleButton)
        
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

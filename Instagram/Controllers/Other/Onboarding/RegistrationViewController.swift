//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by akash on 25/12/22.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        
    }
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor( .white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
        view.addSubview(emailField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.backgroundColor = .systemBackground
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
        usernameField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width - 40, height:  52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 20, width: view.width - 40, height: 52)
    }

    @objc private func didTapRegisterButton () {
        
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty, email.contains("@"),
        let username = usernameField.text, !username.isEmpty,
        let password = passwordField.text, !password.isEmpty, password.count >= 8
        else {
            return
            
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    //good to go
                }
                else {
                    //failed
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            usernameField.becomeFirstResponder()
        }
        else if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapRegisterButton()
        }
        return true
    }
}

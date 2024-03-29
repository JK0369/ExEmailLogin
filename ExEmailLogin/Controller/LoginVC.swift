//
//  LoginVC.swift
//  ExEmailLogin
//
//  Created by 김종권 on 2021/11/18.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "abcdef@gmail.com"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일:"
        label.textColor = .label
        return label
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("이메일로 인증 링크 전송", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(emailLabel)
        view.addSubview(authButton)
        view.addSubview(loginButton)
    }
    
    private func makeConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        authButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        
        emailLabel.trailingAnchor.constraint(equalTo: authButton.leadingAnchor, constant: -8).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        
        authButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: 16).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func didTapAuthButton() {
        guard let email = emailTextField.text else { return }
        
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://sample-9ca7b.firebaseapp.com/?email=\(email)")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        Auth.auth().sendSignInLink(toEmail: email,
                                   actionCodeSettings: actionCodeSettings) { error in
            if let error = error {
                print("email not sent \"\(error.localizedDescription)\"")
            } else {
                print("email sent")
            }
        }
    }
    
    @objc private func didTapLoginButton() {
        guard let email = emailTextField.text,
              let link = UserDefaults.standard.string(forKey: "Link") else { return }
        Auth.auth().signIn(withEmail: email, link: link) { [weak self] result, error in
            if let error = error {
                print("email auth error \"\(error.localizedDescription)\"")
                return
            }
//            let homeVC = HomeVC()
//            self?.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}

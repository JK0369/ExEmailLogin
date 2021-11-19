//
//  AppController.swift
//  ExEmailLogin
//
//  Created by 김종권 on 2021/11/18.
//

import Foundation
import UIKit
import Firebase

final class AppController {
    static let shared = AppController()
    private init() {
        FirebaseApp.configure()
        registerAuthStateDidChangeEvent()
    }
    
    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
        }
    }
    
    func show(in window: UIWindow) {
        self.window = window
        window.backgroundColor = .systemBackground
        window.makeKeyAndVisible()
        
        checkLoginIn()
    }
    
    private func registerAuthStateDidChangeEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkLoginIn),
                                               name: .AuthStateDidChange, // <- Firebase Auth 이벤트
                                               object: nil)
    }
        
    @objc private func checkLoginIn() {
        if let user = Auth.auth().currentUser { // <- Firebase Auth
            print("user = \(user)")
            setHome()
        } else {
            routeToLogin()
        }
    }
    
    private func setHome() {
        let homeVC = HomeVC()
        rootViewController = UINavigationController(rootViewController: homeVC)
    }

    private func routeToLogin() {
        rootViewController = UINavigationController(rootViewController: LoginVC())
    }
    
}

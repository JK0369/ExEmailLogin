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
        FirebaseApp.configure() // <- Fierbase 초기화
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
        
        // 로그인이 된 경우 AuthStateDidChange가 불리므로 2중으로 checkLogin이 불리지 않도록 설정
        if Auth.auth().currentUser == nil {
            checkLogin()
        }
    }
    
    private func registerAuthStateDidChangeEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkLogin),
                                               name: .AuthStateDidChange, // <- Firebase Auth 이벤트
                                               object: nil)
    }
        
    @objc private func checkLogin() {
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

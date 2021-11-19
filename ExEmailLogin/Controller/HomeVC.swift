//
//  HomeVC.swift
//  ExEmailLogin
//
//  Created by 김종권 on 2021/11/18.
//

import UIKit

class HomeVC: UIViewController {
    
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "로그인 완료 !!!"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeLabel)
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

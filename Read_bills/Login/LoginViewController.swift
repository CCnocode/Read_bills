//
//  LoginViewController.swift
//  Read_bills
//
//  Created by chang xing on 05/08/2022.
//

import UIKit

class LoginViewController: UIViewController{
    
    //login view
    let loginView = LoginView()
    
    //add login botton
    let btnLogin = UIButton(type: .system)
    
    //add title
    let lblTitle = UILabel();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        _loginview()
        _lblTitle()
        _btnlogin()
        
    }
}

extension LoginViewController{
    
    func _loginview(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        // add loginView UI
        view.addSubview(loginView)
        
        //add constrain for login View
        NSLayoutConstraint.activate([
            //top side
            //loginView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
        
            //center side
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //left side
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            //right side
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            //bot side
            //loginView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 80),
            
        ])
    }
    
    func _btnlogin(){
        //basic attribution
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.configuration = .filled()
        btnLogin.configuration?.imagePadding = 10
        btnLogin.setTitle("Login", for: [])
        btnLogin.addTarget(self, action: #selector(btnLogin_Tapped), for: .primaryActionTriggered)
        
        //add to view
        view.addSubview(btnLogin)
        
        NSLayoutConstraint.activate([
            btnLogin.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 3),
            
            btnLogin.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            
            btnLogin.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
    }
    
    func _lblTitle(){
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        lblTitle.adjustsFontForContentSizeCategory = true
        lblTitle.text = "User Login"
        
        view.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            //CENTER
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //top
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: lblTitle.bottomAnchor, multiplier: 3),
        ])
    }
}

extension LoginViewController{
    @objc func btnLogin_Tapped(sender: UIButton){
        print("Buttton pressed")
    }
}

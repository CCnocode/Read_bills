//
//  LoginView.swift
//  Read_bills
//
//  Created by chang xing on 03/08/2022.
//

import UIKit

class LoginView: UIView{
    
    //stack
    let stackView = UIStackView()
    
    //divide line
    let dividerView = UIView()
    
    //username
    let TxtUsername = UITextField()
    
    //password
    let TxtPassword = UITextField()
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        //gray bakground color
        self.backgroundColor = .systemGray6
        
        //make the input TextField circle
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        //view setting
        _stackview()
        _username()
        _dividerView()
        _password()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LoginView{
    
    func _stackview(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        //add the view
        self.addSubview(stackView)
        
        //add constrains
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 1),
            
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
        ])
    }
    
    func _dividerView(){
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .black
        
        stackView.addArrangedSubview(dividerView)
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func _username() {
        //basic attribution
        TxtUsername.translatesAutoresizingMaskIntoConstraints = false
        TxtUsername.font = UIFont.preferredFont(forTextStyle: .title2)
        TxtUsername.placeholder = "Username"
        TxtUsername.autocapitalizationType = .none
        TxtUsername.autocorrectionType = .no
        
        //delegate event
        TxtUsername.delegate = self
        
        //add view
        //self.addSubview(TxtUsername)
        
        stackView.addArrangedSubview(TxtUsername)
    }
    
    func _password(){
        //basic attribution
        TxtPassword.translatesAutoresizingMaskIntoConstraints = false
        TxtPassword.font = UIFont.preferredFont(forTextStyle: .title2)
        TxtPassword.placeholder = "Password"
        
        //password shows * in text
        TxtPassword.isSecureTextEntry = true
        
        //delegate event
        TxtPassword.delegate = self
        
        //add view
        //self.addSubview(TxtPassword)
        stackView.addArrangedSubview(TxtPassword)
    }
}

//event delegate
extension LoginView: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Listening!")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Start Edit")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Before stop Listenin")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("Stop Edit")
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Text input clear")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Press return")
        textField.endEditing(true)
        return true
    }
    
}


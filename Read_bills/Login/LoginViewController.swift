//
//  LoginViewController.swift
//  Read_bills
//
//  Created by chang xing on 05/08/2022.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject{
    func didLoginSuccess()
}

class LoginViewController: UIViewController{
    
    //event
    weak var delegate: LoginViewControllerDelegate?
    
    var status = false
    
    //login view
    let loginView = LoginView()
    
    //add login botton
    let btnLogin = UIButton(type: .system)
    
    //add text box
    let lblMessage = UILabel()
    
    //add title
    let lblTitle = UILabel()
    
    //add regist btn
    let btnRegist = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .white
        view.layer.contents = UIImage(named: "London")?.cgImage
        
        _loginview()
        _lbltitle()
        _btnlogin()
        _btnregist()
        _lblmessage()
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
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            //right side
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
            
            //bot side
            //loginView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 80),
            
        ])
    }
    
    func _btnlogin(){
        //basic attribution
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.configuration = .filled()
        btnLogin.configuration?.imagePadding = 10
        btnLogin.layer.cornerRadius = 20
        btnLogin.setTitle("Sign In", for: [])
        btnLogin.addTarget(self, action: #selector(btnLogin_Tapped), for: .primaryActionTriggered)
        
        //add to view
        view.addSubview(btnLogin)
        
        NSLayoutConstraint.activate([
            btnLogin.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 3),
            
            btnLogin.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            
            btnLogin.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
    }
    
    func _btnregist(){
        //basic attribution
        btnRegist.translatesAutoresizingMaskIntoConstraints = false
        btnRegist.configuration = .filled()
        btnRegist.configuration?.imagePadding = 10
        btnRegist.layer.cornerRadius = 20
        btnRegist.setTitle("Create Account", for: [])
        btnRegist.addTarget(self, action: #selector(btnRegist_Tapped), for: .primaryActionTriggered)
        
        //add to view
        view.addSubview(btnRegist)
        
        NSLayoutConstraint.activate([
            btnRegist.topAnchor.constraint(equalToSystemSpacingBelow: btnLogin.bottomAnchor, multiplier: 1),
            
            btnRegist.leadingAnchor.constraint(equalTo: btnLogin.leadingAnchor),
            
            btnRegist.trailingAnchor.constraint(equalTo: btnLogin.trailingAnchor)
        ])
    }
    
    func _lblmessage(){
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        lblMessage.textAlignment = .left
        lblMessage.textColor = .systemRed
        lblMessage.numberOfLines = 0
        lblMessage.isHidden = false
        
        view.addSubview(lblMessage)
        
        NSLayoutConstraint.activate([
            lblMessage.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: btnRegist.bottomAnchor, multiplier: 2),
            
            lblMessage.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            
            lblMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
    
    func _lbltitle(){
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
    
    //User Login
    @objc func btnLogin_Tapped(sender: UIButton){
        print("login Buttton pressed")
        lblMessage.isHidden = true
        guard let uid = loginView.TxtUsername.text,
              let pwd = loginView.TxtPassword.text else{
                    return
        }
        
        //Deal with Empty input
        if uid.isEmpty || pwd.isEmpty{
            lblMessage.isHidden = false
            
            lblMessage.text = "Input info cant be empty"
            
            return
        }
        
        //check if the user exist
        check_user(ID:uid,PW:pwd)
        btnLogin.configuration?.showsActivityIndicator = true
        btnLogin.setTitle("Login...", for: [])
        
        
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                
                self.btnLogin.configuration?.showsActivityIndicator = false
                self.btnLogin.setTitle("Sign In", for: [])
                //Successful user login
                if self.status{
                    //hunman addcdelay
                    self.delegate?.didLoginSuccess()
                } else{
                    self.lblMessage.isHidden = false
                    self.lblMessage.text = "Login Faild"
                    return
                }
            }
        }
    }
    
    //Create Account
    @objc func btnRegist_Tapped(sender: UIButton){
        print("Regist Buttton pressed")
        lblMessage.isHidden = true
        guard let uid = loginView.TxtUsername.text,
              let pwd = loginView.TxtPassword.text else{
                    return
        }
        
        //Deal with Empty input
        if uid.isEmpty || pwd.isEmpty{
            lblMessage.isHidden = false
            
            lblMessage.text = "Account info cant be empty"
            
            return
        }
        
        //check if the user exist
        create_user(ID:uid,PW:pwd)
        btnRegist.configuration?.showsActivityIndicator = true
        btnRegist.setTitle("Creat Account...", for: [])
        
        
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                
                self.btnRegist.configuration?.showsActivityIndicator = false
                //Successful create
                if self.status{
                    //hunman addcdelay
                    self.lblMessage.isHidden = false
                    self.lblMessage.text = "Acount create successful"
                } else{
                    self.lblMessage.isHidden = false
                    self.lblMessage.text = "Acount has already exist"
                    return
                }
            }
        }
    }
}

extension LoginViewController{
    
    func check_user(ID:String, PW:String){
        let usernametext = ID
        let passwordtext = PW
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/Search_login.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(usernametext)&password=\(passwordtext)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [self]
            data, response, error in

            if error != nil {
                print("error=\(String(describing: error))")
                return
            }

            //print("response = \(String(describing: response))")

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString!))")
            
            let obj: String = responseString! as String

            if obj == "true"{
                self.status = true
            } else{
                self.status = false
            }
        }
        task.resume()
    }
}


extension LoginViewController{
    func create_user(ID:String, PW:String){
        let usernametext = ID
        let passwordtext = PW
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/Create_user.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(usernametext)&password=\(passwordtext)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [self]
            data, response, error in

            if error != nil {
                print("error=\(String(describing: error))")
                return
            }

            //print("response = \(String(describing: response))")

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString!))")
            
            let obj: String = responseString! as String

            if obj == "true"{
                self.status = true
            } else{
                self.status = false
            }
        }
        task.resume()
    }
}

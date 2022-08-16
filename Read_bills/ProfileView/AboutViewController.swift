//
//  AboutViewController.swift
//  Read_bills
//
//  Created by chang xing on 06/08/2022.
//

import UIKit

protocol AboutViewControllerDelegate: AnyObject{
    func didLogout()
}


class AboutViewController: UIViewController{
    
    //event delegate
    weak var delegate: AboutViewControllerDelegate?
    
    //Add a stack
    let stackView = UIStackView()
    
    //Add Title
    let lblTitle = UILabel()
    
    //add image model
    let imgLogo = UIImageView()
    
    //add a logout button
    let btnLogout = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //Set the component
        _stackview()
        _lbltitle()
        _imglogo()
        _btnlogout()
    }
}

extension AboutViewController{
    func _stackview(){
        stackView.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //set the stack to vertical
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        //add the view
        view.addSubview(stackView)
        
        //add constraint
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
        ])
    }
    
    func _lbltitle(){
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        lblTitle.adjustsFontForContentSizeCategory = true
        lblTitle.text = "Application Intro"
        
        stackView.addArrangedSubview(lblTitle)
    }
    
    func _imglogo(){
        //Choose a image in the Assets
        let showImg = UIImage(named: "London")
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        imgLogo.contentMode = .scaleAspectFit
        imgLogo.image = showImg
        
        imgLogo.layer.borderColor = UIColor(red:52/255, green: 52/255, blue: 89/255, alpha: 1).cgColor
        
        imgLogo.layer.borderWidth = 1
        
        stackView.addArrangedSubview(imgLogo)
        
    }
    
    func _btnlogout(){
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.setTitle("Logout System", for: .normal)
        btnLogout.configuration = .filled()
        btnLogout.configuration?.imagePadding = 10
        btnLogout.configuration?.baseBackgroundColor = UIColor(red: 52/255, green: 199/255, blue: 52/255, alpha: 1)
        btnLogout.configuration?.cornerStyle = .capsule
        view.addSubview(btnLogout)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: btnLogout.bottomAnchor, multiplier: 1),
            btnLogout.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: btnLogout.trailingAnchor, multiplier: 1),
            btnLogout.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: btnLogout.topAnchor, multiplier: 5),
        ])
        
        btnLogout.addTarget(self, action: #selector(btnLogout_Tapped), for: .primaryActionTriggered)
        
    }
}


extension AboutViewController{
    @objc func btnLogout_Tapped(sender: UIButton){
        print("Logout Pressed")
        self.delegate?.didLogout()
    }
}

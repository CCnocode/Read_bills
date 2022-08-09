//
//  GuideDetailViewController.swift
//  Read_bills
//
//  Created by chang xing on 06/08/2022.
//

import Foundation

import UIKit

protocol GuideDetailViewControllerDelegate: AnyObject {
    func didGuideClose()
}



class GuideViewDetailController: UIViewController{
    
    //delegate pass into this controller
    weak var delegate: GuideDetailViewControllerDelegate?
    
    
    let stackView = UIStackView()
    
    let lblTitle = UILabel()
    
    let imgLogo = UIImageView()
    
    let lblContent = UILabel()
    
    let showImage: String
    let showContent: String
    
    let showCloseButton: Bool
    
    //Close Button
    let btnClose = UIButton(type: .close)
    
    init(imageName: String, content: String, showClose: Bool = false){
        self.showImage = imageName
        self.showContent = content
        self.showCloseButton = showClose
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("GuideDetail init(coder: ) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background color
        view.backgroundColor = .white
        
        _stackview()
        _lbltitle()
        _imglogo()
        _lblcontent()
        
        if self.showCloseButton{
            _btnclose()
        }
    }
}

extension GuideViewDetailController{
    
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
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
        ])
    }
    
    func _lbltitle(){
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        lblTitle.adjustsFontForContentSizeCategory = true
        lblTitle.textColor = .lightGray
        lblTitle.text = "Application Intro"
        
        stackView.addArrangedSubview(lblTitle)
    }
    
    func _imglogo(){
        //Choose a image in the Assets
        let showImg = UIImage(named: self.showImage)
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        imgLogo.contentMode = .scaleAspectFit
        imgLogo.image = showImg
        
        imgLogo.layer.borderColor = UIColor(red:52/255, green: 52/255, blue: 89/255, alpha: 1).cgColor
        
        imgLogo.layer.borderWidth = 10
        
        stackView.addArrangedSubview(imgLogo)
        
    }
    
    func _lblcontent(){
        lblContent.adjustsFontForContentSizeCategory = false
        lblContent.font = UIFont.preferredFont(forTextStyle: .title2)
        lblContent.textColor = .darkGray
        lblContent.numberOfLines = 0
        lblContent.text = self.showContent
        
        stackView.addArrangedSubview(lblContent)
    }
    
    func _btnclose(){
        let picture = UIImage(named: "xmark.circle")
        btnClose.setImage(picture, for: .normal)
        btnClose.configuration = .filled()
        btnClose.tintColor = .systemRed
        btnClose.frame = CGRect(x: view.bounds.width - 40,
                                y: (UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 20) + 6,
                                width: 32,
                                height: 32)
        btnClose.addTarget(self, action: #selector(btnClose_Tapped), for: .primaryActionTriggered)
        
        view.addSubview(btnClose)
    }
}

extension GuideViewDetailController{
    @objc func btnClose_Tapped(){
        print("Close Button Pressed")
        
        self.delegate?.didGuideClose()
    }
}

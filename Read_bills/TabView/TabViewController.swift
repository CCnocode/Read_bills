//
//  TabViewController.swift
//  Read_bills
//
//  Created by chang xing on 08/08/2022.
//

import UIKit
import SwiftUI

class TabViewController: UITabBarController,ProfileViewDelegate{
    func didLogout() {
        print("come in")
        Logout_delegate?.didLogout()
    }

    weak var Logout_delegate: ProfileViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setStatusBar()
        
        //view controller
        //let vc1 = TabDetailViewController(tabTitle: "1", bgColor: .systemYellow)
        let vc1 = PieChartViewController()
        
        let temp_2 = UploadView()
        let vc2 = UIHostingController(rootView: temp_2)
        
        var temp_3 = ProfileView(First_name:LocalState.First_name, Last_name:LocalState.Last_name, Address:LocalState.Address, PostCode:LocalState.PostCode);
        temp_3.delegate = self
        let vc3 = UIHostingController(rootView: temp_3)
        //vc3.delegate = self
         
        vc1.tabBarItem = UITabBarItem(title: "Data", image: UIImage(named: "show")?.withRenderingMode(.alwaysOriginal), tag: 0)
        vc2.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(named: "upload")?.withRenderingMode(.alwaysOriginal), tag: 1)
        vc3.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "user")?.withRenderingMode(.alwaysOriginal), tag: 2)
        
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)
        
        nc1.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        nc2.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        nc3.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        
        tabBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        self.viewControllers = [nc1,nc2,nc3]
        
    }
    
    func setStatusBar(){
        var statusBarSize: CGSize
        let scenes = UIApplication.shared.connectedScenes
        let windoScene = scenes.first as? UIWindowScene
        let window = windoScene?.windows.first
        
        statusBarSize = window?.windowScene?.statusBarManager?.statusBarFrame.size ?? CGSize()
        
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusbarView = UIView(frame: frame)
        
        statusbarView.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        view.addSubview(statusbarView)
    }
    
}

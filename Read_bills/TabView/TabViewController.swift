//
//  TabViewController.swift
//  Read_bills
//
//  Created by chang xing on 08/08/2022.
//

import UIKit

class TabViewController: UITabBarController,AboutViewControllerDelegate{
    func didLogout() {
        print("come in")
        About_delegate?.didLogout()
    }

    weak var About_delegate: AboutViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setStatusBar()
        
        //view controller
        let vc1 = TabDetailViewController(tabTitle: "1", bgColor: .systemYellow)
        let vc2 = TabDetailViewController(tabTitle: "2", bgColor: .systemTeal)
        let vc3 = TabDetailViewController(tabTitle: "3", bgColor: .systemBlue)
        //let vc4 = TabDetailViewController(tabTitle: "4", bgColor: .systemMint)
        let vc4 = AboutViewController()
        vc4.delegate = self
        
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        vc4.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)
        let nc4 = UINavigationController(rootViewController: vc4)
        
        nc1.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        nc2.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        nc3.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        nc4.navigationBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        
        tabBar.backgroundColor = UIColor(red: 242/255, green: 247/255, blue: 247/255, alpha: 1)
        self.viewControllers = [nc1,nc2,nc3,nc4]
        
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

class TabDetailViewController: UIViewController{
    let _title: String
    let _bgColor: UIColor
    init(tabTitle:String, bgColor:UIColor = .white){
        self._title = tabTitle
        self._bgColor = bgColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = self._title
        view.backgroundColor = self._bgColor
    }
}

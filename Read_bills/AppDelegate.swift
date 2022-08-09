//
//  AppDelegate.swift
//  Read_bills
//
//  Created by chang xing on 03/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    //give list of ViewController
    let GuideShow_vc = GuideViewController()
    let Login_vc = LoginViewController()
    let About_vc = AboutViewController()
    let TabView_vc = TabViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        // Override point for customization after application launch.
        
        //sent the delegate to the GuideOverall
        if LocalState.LoginSuccess{
            About_vc.delegate = self
            TabView_vc.About_delegate = About_vc.delegate
            setRootViewController(TabView_vc)
        } else{
            let start_vc = GuideShow_vc
            
            start_vc.delegate = self
            
            window?.rootViewController = start_vc
        }
        
        return true
    }
    
}

extension AppDelegate{
    func setRootViewController(_ vc: UIViewController, animated: Bool = true){
        guard animated, let window = self.window else{
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension AppDelegate: GuideDetailViewControllerDelegate{
    func didGuideClose() {
        print("AppDelegate. Guide Close")
        Login_vc.delegate = self
        setRootViewController(Login_vc)
    }
}

extension AppDelegate:LoginViewControllerDelegate{
    func didLoginSuccess() {
        //user login status
        LocalState.LoginSuccess = true
        About_vc.delegate = self
        TabView_vc.About_delegate = About_vc.delegate
        setRootViewController(TabView_vc)
        print("User Login Successful")
    }
}

extension AppDelegate: AboutViewControllerDelegate{
    func didLogout() {
        //user logout
        LocalState.LoginSuccess = false
        Login_vc.delegate = self
        setRootViewController(Login_vc)
    }
}


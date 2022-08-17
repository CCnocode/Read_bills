//
//  AppDelegate.swift
//  Read_bills
//
//  Created by chang xing on 03/08/2022.
//

import UIKit
import Firebase
import SwiftUI
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    //give list of ViewController
    let GuideShow_vc = GuideViewController()
    let Login_vc = LoginViewController()
    let About_vc = AboutViewController()
    let TabView_vc = TabViewController()
    
    //var Profile_vc = ProfileView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        // Override point for customization after application launch.
        
        //sent the delegate to the GuideOverall
        if LocalState.LoginSuccess{
            //TabView_vc.Logout_delegate = self
            let temp = UploadView()
            let obj = UIHostingController(rootView: temp)
            
            setRootViewController(obj)
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
            vc.viewDidLoad()
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        vc.viewDidLoad()
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
        TabView_vc.Logout_delegate = self
        
        UIAlertController.showAlert(message: "Login Successful", in: Login_vc)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.setRootViewController(self.TabView_vc)
        }
        print("User Login Successful")
    }
}

extension AppDelegate: ProfileViewDelegate{
    func didLogout() {
        //user logout
        LocalState.LoginSuccess = false
        Login_vc.delegate = self
        setRootViewController(Login_vc)
    }
}

extension UIAlertController{
    static func showAlert(message: String, in viewController:UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel))
        viewController.present(alert, animated: true)
    }
}

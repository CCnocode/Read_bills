//
//  GuideViewController.swift
//  Read_bills
//
//  Created by chang xing on 06/08/2022.
//

import UIKit

class GuideViewController: UIViewController{

    weak var delegate: GuideDetailViewControllerDelegate?
    
    //pages component
    let pageViewController: UIPageViewController
    
    //page arrays
    var pages = [UIViewController]()
    var currentVC:UIViewController{
        didSet{
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = GuideViewDetailController(imageName: "Step1", content: "If you are a new user using this app for the first time, please register your own account. After the registration is successful, click the Login button to enter the main interface.")
        let page2 = GuideViewDetailController(imageName: "Step2", content: "The second page is about user profile info, where you can enter your personal info and current address.")
        let page3 = GuideViewDetailController(imageName: "Step3", content: "You can choose to upload your bills on the upload page. There are two ways to upload the bill: file upload and album upload.")
        let page4 = GuideViewDetailController(imageName: "Step4", content: "The final data page shows all the bill info of user. Click refresh to update the latest data at any time.", showClose: true)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)

        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background color
        view.backgroundColor = .systemIndigo
        
        //Set delegate for the last page
        if let LastVC = pages.last as? GuideViewDetailController{
            LastVC.delegate = self.delegate
        }
        
        _PageLoad()
    }
}

extension GuideViewController{
    func _PageLoad(){
        //add pages to the parent view
        super.addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        //set the source data
        pageViewController.dataSource = self
        
        //add constraints
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        
        currentVC = pages.first!
    }
}


extension GuideViewController: UIPageViewControllerDataSource {
    
    //back to the previous
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        return getPreviousViewController(from: viewController)
    }
    
    //back to the next view
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        return getNextViewController(from: viewController)
    }
    
    //check pages amount
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    //return current page index
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController), index-1 >= 0 else {return nil}
        
        currentVC = pages[index - 1]
        
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController), index+1 < pages.count else {return nil}
        
        currentVC = pages[index + 1]
        
        return pages[index + 1]
    }
}

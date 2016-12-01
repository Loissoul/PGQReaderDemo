//
//  PGQNavigationViewController.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQNavigationViewController: UINavigationController {

    override class func initialize(){
    
        self.setupNacTheme()
    }
    
    //设置导航栏属性
    class func setupNacTheme() {
        let navBar:UINavigationBar = UINavigationBar.appearance()
        //设置标题属性
        let textAttrs:NSDictionary = [NSForegroundColorAttributeName:PGQColor_4, NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
        navBar.titleTextAttributes = textAttrs as? [String : AnyObject]
    }
    //设置item
    class func setupBarButtonItemTheme() {
        
        let item = UIBarButtonItem.appearance()
        
        let textAttrs = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName:UIFont.systemFont(ofSize: 18)];
        item.setTitleTextAttributes(textAttrs, for: UIControlState())
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0  {
        
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.AppNavigationBarBackItemOne(UIEdgeInsetsMake(0, 0, 0, 0), target: self, action: #selector(PGQNavigationViewController.clickBack))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //点击返回
    func clickBack() {
        popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}






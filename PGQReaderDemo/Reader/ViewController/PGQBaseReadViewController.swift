//
//  PGQBaseReadViewController.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQBaseReadViewController: UIViewController {

    //MARK: - 返回手势
    var openInteractivePopGestureRecognizer:Bool = true {
        didSet{
            navigationController?.interactivePopGestureRecognizer?.isEnabled = openInteractivePopGestureRecognizer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        self.initNavigationBarSubviews()
        addSubViews()
    }
    
    func addSubViews() {
        //返回手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    func initNavigationBarSubviews() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: 记录当前的显示的控制器
        
        
        //删除系统自动生成的UITabBarButton
        deleItem()
    }
    
    func deleItem() {
        if (self.tabBarController != nil ) {
            for child:UIView in self.tabBarController!.tabBar.subviews {
                if child.isKind(of: UIControl.self) {
                    child.removeFromSuperview()
                }
            }
        }
    }
    
    func clickBack() {
        let _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




    //
//  ViewController.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var readVC:PGQPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let button = UIButton(type:UIButtonType.custom)
        button.setTitle("Start", for: UIControlState.normal)
        button.backgroundColor = UIColor.blue
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(button)
        button.addTarget(self, action: #selector(ViewController.read), for: UIControlEvents.touchDown)

    }
    
    func read() {
        MBProgressHUD.showMessage("请等待")
        let fuleURL = Bundle.main.url(forResource: "求魔", withExtension: "txt")
        
        
        readVC = PGQPageViewController()
        
        PGQTextParser.separateLocalURL(fuleURL!) { [weak self] (isOK) in
            
            MBProgressHUD.hide()
            
            if self != nil {
                
                self!.readVC!.readModel = PGQReadModel.getReadModelWithFile("求魔")
                
                self!.navigationController?.pushViewController(self!.readVC!, animated: true)
                
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


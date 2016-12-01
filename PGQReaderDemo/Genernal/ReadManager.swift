//
//  ReadManager.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class ReadManager: NSObject {

    class var ShareManager: ReadManager {
        
        struct Static {
        
            static let instance :ReadManager = ReadManager()
        }
            return Static.instance
    }
    weak var displayController:UIViewController?
}

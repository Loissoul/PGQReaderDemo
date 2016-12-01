//
//  PGQReadView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadView: UIView {
    
    var content:String! //当前文字
    
    var frameRef:CTFrame? {
    
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if frameRef == nil {
            return
        }
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.textMatrix = CGAffineTransform.identity
        ctx?.translateBy(x: 0, y: self.bounds.size.height)
        ctx?.scaleBy(x: 1.0, y: -1.0)
        CTFrameDraw(frameRef!, ctx!)
    }
    
}

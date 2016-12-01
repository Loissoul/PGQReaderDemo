//
//  PGQReadLeftView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/14.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadLeftHeaderView: UIView {
    fileprivate var textLabel:UILabel!
    fileprivate var spaceLine:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        createView()
    }
    
    func createView() {
        textLabel = UILabel()
        textLabel.text = "全部章节"
        textLabel.textColor = PGQColor_4
        textLabel.font = UIFont.fontOfSize(10)
        textLabel.frame = CGRect(x: 18, y: 10, width: 50, height: 15)
        addSubview(textLabel)
        
        spaceLine = SetUpViewLine(self, color: PGQColor_6)
        spaceLine.frame = CGRect(x: 0, y: height - PGQSpaceLineHeight, width: width, height: PGQSpaceLineHeight)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

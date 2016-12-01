//
//  PGQReadSettingCustomView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/15.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadSettingCustomView: UIView {

    var spaceLine:UIView! //分割线
    
    var titleLabel:UILabel! //title
    
    var nomalNames:[String]! = []

    var Buttons:[UIButton]! = []     /// 按钮数组
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        
        createViews()
    }
    
    
    func createViews() {
        
        let spaceW:CGFloat = PGQReadSettingSpaceW

        // title
        titleLabel = UILabel()
        titleLabel.font = UIFont.fontOfSize(14)
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: spaceW, y: 0, width: 60, height: height)

        addSubview(titleLabel)
        
        // 创建按钮
        for i in 0..<nomalNames.count {
            
            let tempX:CGFloat = titleLabel.frame.maxX
            let buttonW = (width - tempX - spaceW) / CGFloat(nomalNames.count)

            let button = UIButton(type:UIButtonType.custom)
            button.tag = i
            button.setTitle(nomalNames[i], for: UIControlState())
            button.setTitleColor(UIColor.black, for: UIControlState())
            button.setTitleColor(PGQColor_4, for: UIControlState.selected)
            button.titleLabel?.font = UIFont.fontOfSize(14)
            button.frame = CGRect(x: tempX + CGFloat(i) * buttonW, y: 0, width: buttonW, height: height)

            addSubview(button)
            Buttons.append(button)
        }
        
        // 分割线
        spaceLine = SetUpViewLine(self, color: PGQColor_6)
        spaceLine.frame = CGRect(x: 0, y: height - PGQSpaceLineHeight, width: width, height: PGQSpaceLineHeight)

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  PGQReadSettingColorView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/15.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

@objc protocol PGQReadSettingColorViewDelegate:NSObjectProtocol {

    @objc optional func readSettingColorView(_ readSettingColorView:PGQReadSettingColorView, changReadColor readColor:UIColor)
}

class PGQReadSettingColorView: UIScrollView {

    //delegate
    weak var aDelegate:PGQReadSettingColorViewDelegate?
    
    //分割线
    fileprivate var spaceLine:UIView!
    
    //选中的button
    fileprivate var selectButton:UIButton?
    
    //当前按钮
    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        createView()
    }
    
    func createView(){
        
        let count = PGQReadColors.count
        
        for i in 0..<count {
            
            // 左右间距
            let spaceW:CGFloat = PGQReadSettingSpaceW
            
            let buttoonWH:CGFloat = 36
            
            let buttoonY:CGFloat = (height - buttoonWH) / 2
            
            let centerSpaceW:CGFloat = (width - 2*spaceW - buttoonWH*CGFloat(count)) / (CGFloat(count) - 1)
            
            let backGroundColor = PGQReadColors[i]
            let button = UIButton(type: UIButtonType.custom)
            button.tag = i
            button.layer.borderColor = PGQColor_4.cgColor
            button.layer.borderWidth = backGroundColor == PGQColor_13 ? 1 : 0
            button.backgroundColor = backGroundColor
            button.frame = CGRect(x: spaceW + CGFloat(i) * (buttoonWH + centerSpaceW), y: buttoonY, width: buttoonWH, height: buttoonWH)
            
            button.layer.cornerRadius = buttoonWH/2

            button.addTarget(self, action: #selector(PGQReadSettingColorView.clickButtonChangeColor(_:)), for: UIControlEvents.touchUpInside)
            addSubview(button)
            
            if i == PGQReaderConfigureManager.shareManager.readColorInex.intValue {
                clickButtonChangeColor(button)
            }
        }
        
        //分割线
        spaceLine = SetUpViewLine(self, color: PGQColor_6)
        spaceLine.frame = CGRect(x: 0, y: height - PGQSpaceLineHeight, width: width, height: PGQSpaceLineHeight)
    }
    
    
    func clickButtonChangeColor(_ button:UIButton) {
        if selectButton == button{ return }
        selectButton?.layer.borderWidth -= 1
        button.layer.borderWidth += 1
        selectButton = button
        let readColor = PGQReadColors[button.tag]
        PGQReaderConfigureManager.shareManager.readColorInex = NSNumber(value: button.tag)
        aDelegate?.readSettingColorView?(self, changReadColor: readColor)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}















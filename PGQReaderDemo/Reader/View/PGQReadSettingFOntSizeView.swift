//
//  PGQReadSettingFOntSizeView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/15.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

@objc protocol PGQReadSettingFontSizeViewDeleGate: NSObjectProtocol {

    @objc optional func readSettingFontSizeView(_ readSettingFontSizeView:PGQReadSettingFOntSizeView, changeFontSize fontSize:Int)
}

class PGQReadSettingFOntSizeView: PGQReadSettingCustomView {
    
    weak var delegate: PGQReadSettingFontSizeViewDeleGate? //delegate
    
    fileprivate var minus:UIButton! //减
    
    fileprivate var add:UIButton! // ➕
    
    fileprivate var currentSize:Int = PGQReaderConfigureManager.shareManager.readFontSize.intValue
    
    fileprivate var minusImage:UIImage = UIImage(named: "icon_read_3")!
    
    fileprivate var addImage:UIImage = UIImage(named: "icon_read_4")!


    override init(frame:CGRect) {
    
        super.init(frame: frame)
    
        createViews()
        titleLabel.text = "字号"
        
    }
    
    override func createViews() {
        
        super.createViews()
        
        
        let spaceW = PGQReadSettingSpaceW
        
        let buttonY:CGFloat = (height - addImage.size.height)/2
        
        // 加
        add = UIButton(type:UIButtonType.custom)
        add.frame = CGRect(x: width - spaceW - addImage.size.width, y: buttonY, width: addImage.size.width, height: addImage.size.height)
        
        add.setImage(addImage, for: UIControlState())
        add.addTarget(self, action: #selector(PGQReadSettingFOntSizeView.clickAdd), for: UIControlEvents.touchUpInside)
        addSubview(add)

        // 减
        minus = UIButton(type:UIButtonType.custom)
        minus.frame = CGRect(x: add.frame.minX - minusImage.size.width, y: buttonY, width: minusImage.size.width, height: minusImage.size.height)
        minus.setImage(minusImage, for: UIControlState())
        minus.addTarget(self, action: #selector(PGQReadSettingFOntSizeView.clickMinus), for: UIControlEvents.touchUpInside)
        addSubview(minus)
        
    }
    
    func clickAdd(){
        // 没有大于最大字体
        if (currentSize + 1) <= PGQReadMaxFontSize {
            
            currentSize += 1
            
            PGQReaderConfigureManager.shareManager.readFontSize = currentSize as NSNumber!
            
            delegate?.readSettingFontSizeView?(self, changeFontSize: currentSize)
        }
    }
    
    func clickMinus() {
        // 没有小于最小字体
        if (currentSize - 1) >= PGQReadMinFontSize {
            
            currentSize -= 1
            
            PGQReaderConfigureManager.shareManager.readFontSize = currentSize as NSNumber!
            
            delegate?.readSettingFontSizeView?(self, changeFontSize: currentSize)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




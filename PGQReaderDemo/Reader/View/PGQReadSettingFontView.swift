//
//  PGQReadSettingFontView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

protocol PGQReadSettingFontViewDelegate:NSObjectProtocol {
    
    func readSettingFontView(_ readSettingView: PGQReadSettingFontView, changeFont font: PGQReaderTextFont)
}

class PGQReadSettingFontView: PGQReadSettingCustomView {

    weak var delegate:PGQReadSettingFontViewDelegate?    //delegate
    
    fileprivate var selectButton:UIButton?
    
    override init (frame:CGRect) {
        
        super.init(frame: frame)
        
        nomalNames = ["系统", "黑体", "楷体", "宋体"]
        
        createViews()
        
        titleLabel.text = "字体"
        
        for button in Buttons {
            
            button.contentHorizontalAlignment = .center
            
            button.addTarget(self, action: #selector(PGQReadSettingFontView.clickButton(_:)), for: UIControlEvents.touchUpInside)
        }
        
        if !Buttons.isEmpty {
            clickButton(Buttons[PGQReaderConfigureManager.shareManager.readFont.rawValue])
        }
    }
    
    func clickButton(_ button:UIButton) {
        
        if selectButton == button { return }
        
        selectButton?.isSelected = false
        
        button.isSelected = true
        
        selectButton = button
        
        let readFont = PGQReaderTextFont(rawValue: button.tag)!
        
        PGQReaderConfigureManager.shareManager.readFont = readFont
        
        delegate?.readSettingFontView(self, changeFont: readFont)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

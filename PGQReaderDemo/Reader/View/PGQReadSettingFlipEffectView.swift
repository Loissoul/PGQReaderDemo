//
//  PGQReadSettingFlipEffectView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/15.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

protocol PGQReadSettingFlipEffectViewDelegate:NSObjectProtocol {
    
    func readSettingFlipEffectView(_ readSettingFlipEffectView: PGQReadSettingFlipEffectView, changeFlipEffect flipEffect:PGQReaderFlipStyle)
}

class PGQReadSettingFlipEffectView: PGQReadSettingCustomView {

    weak var delegate:PGQReadSettingFlipEffectViewDelegate?

    fileprivate var selectButton:UIButton?
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        
        nomalNames = ["无效果", "覆盖", "仿真", "上下"]
        
        createViews()
        
        titleLabel.text = "翻书动画"
        
        for button in Buttons {
            
            button.contentHorizontalAlignment = .center
            button.addTarget(self, action: #selector(PGQReadSettingFlipEffectView.clickButton(_:)), for: UIControlEvents.touchUpInside)
            
        }
        if !Buttons.isEmpty {
            clickButton(Buttons[PGQReaderConfigureManager.shareManager.flipEffect.rawValue])
        }
        
    }
    
    func clickButton(_ button:UIButton) {
        if selectButton == button { return }
        
        let flipEffect = PGQReaderFlipStyle(rawValue: button.tag)!
        
        selectButton?.isSelected = false
        button.isSelected = true
        PGQReaderConfigureManager.shareManager.flipEffect = flipEffect
        delegate?.readSettingFlipEffectView(self, changeFlipEffect: flipEffect)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}

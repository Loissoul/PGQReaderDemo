//
//  PGQReadSettingView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

let PGQReadSettingSpaceW:CGFloat = SA(25, other: 30)

class PGQReadSettingView: UIView {

    fileprivate var spaceLine:UIView!    //横线
    
    var setColorView:PGQReadSettingColorView!   //颜色的设置
    
    var setFlipEffectView:PGQReadSettingFlipEffectView!   //翻页效果
    
    var setTextFontSize:PGQReadSettingFOntSizeView!  //字的大小
    
    var setTextFont:PGQReadSettingFontView! //字体
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        createViews()
    }
    
    func createViews() {
        setColorView = PGQReadSettingColorView(frame:CGRect(x: 0, y: 0, width: width, height: 65))
        addSubview(setColorView)
        
        let tempH:CGFloat = (height - setColorView.height) / 3
        
        setFlipEffectView = PGQReadSettingFlipEffectView(frame:CGRect(x: 0, y: setColorView.frame.maxY, width: width, height: tempH))
        addSubview(setFlipEffectView)
        
        setTextFont = PGQReadSettingFontView(frame:CGRect(x: 0, y: setFlipEffectView.frame.maxY, width: width, height: tempH))
        addSubview(setTextFont)
        
        setTextFontSize = PGQReadSettingFOntSizeView(frame:CGRect(x: 0, y: setTextFont.frame.maxY, width: width, height: tempH))
        addSubview(setTextFontSize)
        
        spaceLine = SetUpViewLine(self, color: PGQColor_6)
        spaceLine.frame = CGRect(x: 0, y: 0, width: width, height: PGQSpaceLineHeight)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

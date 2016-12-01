//
//  PGQReadLightView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/15.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

protocol PGQReadLightViewDelegate: NSObjectProtocol {
    
    func readLightView(_ readLightView:PGQReadLightView, lightType:PGQReaderLightStyle)
}

class PGQReadLightView: UIView {

    //delegate
    weak var delegate:PGQReadLightViewDelegate?
    
    fileprivate var slider:UISlider! // 进度条
    
    fileprivate var spaceLine: UIView! //线
    
    fileprivate var textLabel:UILabel! //
    
    fileprivate var lightButton:UIButton! //改变亮度
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        createViews()
    }
    
    func createViews() {
        
        // 进度条
        let sliderW:CGFloat = 208
        let chapterButtonW:CGFloat = (width - sliderW) / 2
        
        slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 0.0
        slider.frame = CGRect(x: chapterButtonW, y: 0, width: sliderW, height: height)

        slider.value = Float(UIScreen.main.brightness)
        slider.tintColor = PGQColor_4
        slider.setThumbImage(UIImage(named:"icon_read_0")!, for: UIControlState())
        slider.addTarget(self, action: #selector(PGQReadLightView.changeValueSlider(_:)), for: UIControlEvents.valueChanged)
        addSubview(slider)
        
        // textLabel
        let textLabelH = slider.frame.minX - PGQSpaceTwo
        textLabel = UILabel()
        textLabel.text = "亮度"
        textLabel.textAlignment = .right
        textLabel.font = UIFont.fontOfSize(14)
        textLabel.frame = CGRect(x: 0, y: 0, width: textLabelH, height: height)
        addSubview(textLabel)

        // lightButton
        let lightButtonX:CGFloat = slider.frame.maxX + PGQSpaceTwo
        let lightButtonW:CGFloat = width - lightButtonX

        lightButton = UIButton(type:UIButtonType.custom)
        lightButton.isSelected = PGQReaderConfigureManager.shareManager.lightTypeNumber.boolValue
        lightButton.setImage(UIImage(named: "icon_read_2"), for: UIControlState())
        lightButton.setImage(UIImage(named: "icon_read_1"), for: UIControlState.selected)
        lightButton.contentHorizontalAlignment = .left
        lightButton.addTarget(self, action: #selector(PGQReadLightView.lightButtonclcik(_:)), for: UIControlEvents.touchUpInside)
        lightButton.frame = CGRect(x: lightButtonX, y: 0, width: lightButtonW, height: height)

        addSubview(lightButton)
        
        //分割线
        spaceLine = SetUpViewLine(self, color: PGQColor_6)
        spaceLine.frame = CGRect(x: 0, y: 0, width: width, height: PGQSpaceLineHeight)
    }
    
    func lightButtonclcik(_ button: UIButton) {
        
        button.isSelected = !button.isSelected
        
        let lightType = PGQReaderLightStyle(rawValue: button.isSelected.hashValue)!
        
        PGQReaderConfigureManager.shareManager.lightType = lightType
        
        delegate?.readLightView(self, lightType: lightType)
    }
    
   @objc fileprivate func changeValueSlider(_ slider:UISlider) {
        UIScreen.main.brightness = CGFloat(slider.value)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




//
//  PGQBatteryView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

var BatterySize:CGSize = CGSize(width: 25, height: 10)

private var PGQBatteryLevelW:CGFloat = 20
private var PGQBatteryLevelScale = PGQBatteryLevelW/BatterySize.width

import UIKit

class PGQBatteryView: UIImageView {

    var batteryLevel:Float = 0{
    
        didSet {
        
            setNeedsLayout()
        }
    }
    
    fileprivate var batteryLevelView:UIView!
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: BatterySize.width, height: BatterySize.height))
    }
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        createViews()
    }
    
    func createViews() {
        
        // 图片
        image = UIImage(named: "Battery")
        
        // 进度
        batteryLevelView = UIView()
        batteryLevelView.layer.masksToBounds = true
        batteryLevelView.backgroundColor = UIColor.black
        addSubview(batteryLevelView)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spaceW:CGFloat = 1 * (frame.width / BatterySize.width) * PGQBatteryLevelScale
        let spaceH:CGFloat = 1 * (frame.height / BatterySize.height) * PGQBatteryLevelScale
        
        let batteryLevelViewY:CGFloat = 2.1*spaceH
        let batteryLevelViewX:CGFloat = 1.4*spaceW
        let batteryLevelViewH:CGFloat = frame.height - 3.4*spaceH
        let batteryLevelViewW:CGFloat = frame.width * PGQBatteryLevelScale
        let batteryLevelViewWScale:CGFloat = batteryLevelViewW / 100
        
        // 判断电量
        var tempBatteryLevel = batteryLevel
        
        if batteryLevel < 0 {
            
            tempBatteryLevel = 0
            
        } else if batteryLevel > 1 {
            
            tempBatteryLevel = 1
            
        } else{}
        
        batteryLevelView.frame = CGRect(x: batteryLevelViewX , y: batteryLevelViewY, width: CGFloat(tempBatteryLevel * 100) * batteryLevelViewWScale, height: batteryLevelViewH)
        batteryLevelView.layer.cornerRadius = batteryLevelViewH * 0.125
    }

    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

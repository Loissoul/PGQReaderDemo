//
//  PGQReadBottomStatusView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

let PGQReadBottomStatusViewH:CGFloat = 30

import UIKit

class PGQReadBottomStatusView: UIView {
    
    fileprivate var numberPageLabel:UILabel! //页码
    fileprivate var timeLabel:UILabel! //时间
    fileprivate var timer:Timer? //倒计时
    fileprivate var batteryView:PGQBatteryView! //电池
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        
        createViews()
    }
    
    func setNumberPage(_ page:Int, tatolPage:Int) {
        numberPageLabel.text = "\(page + 1)/\(tatolPage)"
    }
    
    func createViews() {
        // 页码
        numberPageLabel = UILabel()
        numberPageLabel.textColor = UIColor.black
        numberPageLabel.font = UIFont.fontOfSize(12)
        numberPageLabel.textAlignment = .left
        addSubview(numberPageLabel)
        
        // 时间label
        timeLabel = UILabel()
        timeLabel.textColor = UIColor.black
        timeLabel.font = UIFont.fontOfSize(12)
        timeLabel.textAlignment = .right
        addSubview(timeLabel)
        
        // 电池
        batteryView = PGQBatteryView()
        addSubview(batteryView)
        
        // 添加定时器获取时间
        addTimer()
        didChangeTime()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let h = PGQSpaceTwo
        
        // 页码
        let numberPageLabelW:CGFloat = width/2
        numberPageLabel.frame = CGRect(x: PGQSpaceTwo, y: (height - h)/2, width: width/2, height: h)
        
        // 时间
        let timeLabelW:CGFloat = width - numberPageLabelW - 2*BatterySize.width - PGQSpaceThree
        timeLabel.frame = CGRect(x: numberPageLabel.frame.maxX, y: (height - h)/2, width: timeLabelW, height: h)
        
        // 电池
        batteryView.frame.origin = CGPoint(x: timeLabel.frame.maxX + PGQSpaceThree, y: (height - BatterySize.height)/2)
        
    }
    
    // MARK: -- 时间相关
    
    func addTimer() {
        
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(PGQReadBottomStatusView.didChangeTime), userInfo: nil, repeats: true)
            
            RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    func removeTimer() {
        
        if timer != nil {
            
            timer!.invalidate()
            
            timer = nil
        }
    }
    
    /// 时间变化
    func didChangeTime() {
        
        batteryView.batteryLevel = UIDevice.current.batteryLevel
        
        timeLabel.text = getCurrentTimeString("HH:mm")
    }

    deinit {
        removeTimer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

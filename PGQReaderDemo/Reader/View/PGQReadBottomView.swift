//
//  PGQReadBottomView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/14.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

@objc protocol PGQReadBottomViewDelegate:NSObjectProtocol {

    //点击底部的按钮
    @objc optional func readBottomView(_ readBottomView:PGQReadBottomView, clickBarButtonIndex index: NSInteger)
    
    //下一章
    @objc optional func readBottomViewNextChapter(_ readBottomView:PGQReadBottomView)
    
    //上一章
    @objc optional func readBottomViewLastChapter(_ readBottomView:PGQReadBottomView)
    
    //进度
    @objc optional func readBottomViewChangeSlider(_ readBottomVIew:PGQReadBottomView, slider:UISlider)
}

class PGQReadBottomView: UIView {
    
    // delegate
    weak var delegate:PGQReadBottomViewDelegate?
    
    fileprivate let BarIconNumber:Int = 4 // 图片个数
    
    fileprivate var lastChapter:UIButton! //last chapter
    
    fileprivate var nextChapter:UIButton! //next chapter
    
    var slider:UISlider! // slider
    
    fileprivate var spaceLine:UIView! //分割线
    
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        createView()
        
    }
    
    func createView() {
        
        let buttonH:CGFloat = 70
        
        let buttonY:CGFloat = height - buttonH
        
        let buttonW:CGFloat =  width / CGFloat(BarIconNumber)

        for i in 0..<BarIconNumber {
            let button = UIButton(type:UIButtonType.custom)
            
            button.setImage(UIImage(named: "read_bar_\(i)"), for: UIControlState())
            
            button.tag = i
            
            button.addTarget(self, action: #selector(PGQReadBottomView.clickButton(_:)), for: UIControlEvents.touchUpInside)
            
            button.frame = CGRect(x: CGFloat(i) * buttonW, y: buttonY, width: buttonW, height: buttonH)
            
            addSubview(button)
        }
        
        // 分割线
        spaceLine = SetUpViewLine(self, color: RGB(234, g: 236, b: 242))
        spaceLine.frame = CGRect(x: 0, y: 0, width: width, height: 0.5)
        
        
        // 以下使用的高度
        let tempH:CGFloat = buttonY
        // 进度条
        let sliderW:CGFloat = 208
        var chapterButtonW:CGFloat = (width - sliderW) / 2
        // 按钮位置
        chapterButtonW -= PGQSpaceOne
        
        // 上一章按钮
        lastChapter = UIButton(type:UIButtonType.custom)
        lastChapter.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        lastChapter.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        lastChapter.setTitle("上一章", for: UIControlState())
        lastChapter.setTitleColor(PGQColor_4, for: UIControlState())
        lastChapter.addTarget(self, action: #selector(PGQReadBottomView.clickLastChapter), for: UIControlEvents.touchUpInside)
        lastChapter.frame = CGRect(x: 0, y: 0, width: chapterButtonW, height: tempH)

        addSubview(lastChapter)
        
        
        slider = UISlider()
        slider.minimumValue = 0
        slider.tintColor = PGQColor_4
        slider.setThumbImage(UIImage(named: "icon_read_0")!, for: UIControlState())
        slider.addTarget(self, action: #selector(PGQReadBottomView.sliderChangeProgress), for: UIControlEvents.touchUpInside)
        slider.frame = CGRect(x: chapterButtonW, y: 0, width: sliderW, height: tempH)
        
        addSubview(slider)

        // 下一章按钮
        nextChapter = UIButton(type:UIButtonType.custom)
        nextChapter.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        nextChapter.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        nextChapter.setTitle("下一章", for: UIControlState())
        nextChapter.setTitleColor(PGQColor_4, for: UIControlState())
        nextChapter.addTarget(self, action: #selector(PGQReadBottomView.clickNextChapter), for: UIControlEvents.touchUpInside)
        nextChapter.frame = CGRect(x: slider.frame.maxX + PGQSpaceOne , y: 0, width: chapterButtonW, height: tempH)
        addSubview(nextChapter)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 按钮布局
        
        let buttonH:CGFloat = 70
        
        let buttonY:CGFloat = height - buttonH
        
        let buttonW:CGFloat =  width / CGFloat(BarIconNumber)
        
        for i in 0..<BarIconNumber {
            
            let button = subviews[i]
            
            button.frame = CGRect(x: CGFloat(i) * buttonW, y: buttonY, width: buttonW, height: buttonH)
        }
        
        // 分割线
        spaceLine.frame = CGRect(x: 0, y: 0, width: width, height: 0.5)
        
        // 以下使用的高度
        let tempH:CGFloat = buttonY
        
        // 进度条
        let sliderW:CGFloat = 208
        var chapterButtonW:CGFloat = (width - sliderW) / 2
        slider.frame = CGRect(x: chapterButtonW, y: 0, width: sliderW, height: tempH)
        
        // 按钮位置
        chapterButtonW -= PGQSpaceOne
        lastChapter.frame = CGRect(x: 0, y: 0, width: chapterButtonW, height: tempH)
        nextChapter.frame = CGRect(x: slider.frame.maxX + PGQSpaceOne , y: 0, width: chapterButtonW, height: tempH)
        
    }

    
    //MARK: - Button Action
    //上一章
    func clickLastChapter()  {
        
        delegate?.readBottomViewLastChapter?(self)
    }
    
    //下一章
    func clickNextChapter() {
        delegate?.readBottomViewNextChapter?(self)
    }
    
    /// 点击按钮
    func clickButton(_ button:UIButton) {
        
        delegate?.readBottomView?(self, clickBarButtonIndex: button.tag)
    }

    //修改slider的进度
    @objc fileprivate func sliderChangeProgress() {
        delegate?.readBottomViewChangeSlider?(self, slider: slider)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


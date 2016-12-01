//
//  PGQReadUI.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadUI: NSObject, PGQReadBottomViewDelegate, PGQReadLightViewDelegate {

    //阅读控制器
    fileprivate weak var readPageController:PGQPageViewController!
    
    //UI
    var bottomView:PGQReadBottomView!
    
    fileprivate var lightCoverView:UIView!
    var leftView:PGQReadLeftView!
    var lightView:PGQReadLightView!
    var settingView:PGQReadSettingView!
    
    //阅读控制器设置
    class func readUIWithReadController(_ readPageController:PGQPageViewController) -> PGQReadUI {
        
        let readUI = PGQReadUI()
        readUI.readPageController = readPageController
        readUI.createViews()

        return readUI
    }
    
    func createViews() {
        
        // lightCoverView
        lightCoverView = SetUpViewLine(readPageController.view, color: UIColor.black)
        lightCoverView.isUserInteractionEnabled = false
        setLightCoverView(PGQReaderConfigureManager.shareManager.lightType)
        
        // bottomView
        bottomView = PGQReadBottomView(frame:CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 106))
        bottomView.delegate = self
        readPageController.view.addSubview(bottomView)
        
        // leftView
        leftView = PGQReadLeftView()
        
        // lightView
        lightView = PGQReadLightView(frame:CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 70))
        lightView.delegate = self
        readPageController.view.addSubview(lightView)
        
        // settingView
        settingView = PGQReadSettingView(frame:CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 215))
        readPageController.view.addSubview(settingView)
        
        // frame
        lightCoverView.frame = readPageController.view.bounds
        topView(true,animated: false)
        bottomView(true, animated: false, completion: nil)
        lightView(true, animated: false, completion: nil)
        settingView(true, animated: false, completion: nil)

    }
    
    // MARK: -- HJReadLightViewDelegate
    
    func readLightView(_ readLightView: PGQReadLightView, lightType: PGQReaderLightStyle) {
        
        setLightCoverView(lightType)
    }

    // MARK: -- HJReadBottomViewDelegate
    
    /// 上一章
    func readBottomViewLastChapter(_ readBottomView: PGQReadBottomView) {
        
        readPageController.readSetup.setFlipEffect(PGQReaderConfigureManager.shareManager.flipEffect, chapterID: "\(readPageController.readModel.readRecord.readChapterListModel.chapterID.integeValue() - 1)", chapterLookPageClear: true, contentOffsetYClear: true)
        
    }
    
    /// 下一章
    func readBottomViewNextChapter(_ readBottomView: PGQReadBottomView) {
        
        readPageController.readSetup.setFlipEffect(PGQReaderConfigureManager.shareManager.flipEffect,chapterID: "\(readPageController.readModel.readRecord.readChapterListModel.chapterID.integeValue() + 1)", chapterLookPageClear: true,contentOffsetYClear: true)
    }
    
    /// 拖动进度
    func readBottomViewChangeSlider(_ readBottomView: PGQReadBottomView, slider: UISlider) {
        
        readPageController.readSetup.setFlipEffect(PGQReaderConfigureManager.shareManager.flipEffect,chapterID: "\(Int(slider.value) + 1)",chapterLookPageClear: true, contentOffsetYClear: true)
    }

    
    func readBottomView(_ readBottomView: PGQReadBottomView, clickBarButtonIndex index: NSInteger) {
        
        if (index == 0) { // 目录
            
            leftView(false, animated: true)
            
        }else if (index == 1) { // 亮度
            
            bottomView(true, animated: true, completion: { [weak self] ()->() in
                
                self?.lightView(false, animated: true, completion: nil)
                
                })
            
        }else if (index == 2) { // 设置
            
            bottomView(true, animated: true, completion: { [weak self] ()->() in
                
                self?.settingView(false, animated: true, completion: nil)
                
                })
            
        }else{ // 下载
            
            MBProgressHUD.showMessage("下载存成章节文件,进入沙河看下文件格式")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                
                MBProgressHUD.hide()
            }
        }
    }

    
    /// 设置亮度颜色
    func setLightCoverView(_ lightType:PGQReaderLightStyle) {
        
        if lightType == PGQReaderLightStyle.day {
            
            UIView.animate(withDuration: AnimateDuration, animations: {[weak self] ()->() in
                
                self?.lightCoverView.alpha = 0
                })
            
        }else{
            
            UIView.animate(withDuration: AnimateDuration, animations: {[weak self] ()->() in
                
                self?.lightCoverView.alpha = 0.6
                })
        }
    }
    
    /// topView
    func topView(_ hidden:Bool,animated:Bool) {
        
        // 导航栏操作
        readPageController.navigationController?.setNavigationBarHidden(hidden, animated: animated)
        UIApplication.shared.setStatusBarHidden(hidden, with: UIStatusBarAnimation.slide)
    }
    
    
    /// bottomView
    func bottomView(_ hidden:Bool,animated:Bool,completion:(() -> Void)?) {
        
        setupView(bottomView, viewHeight: 106, hidden: hidden, animated: animated, completion: completion)
    }
    
    
    /// lightView
    func lightView(_ hidden:Bool,animated:Bool,completion:(() -> Void)?) {
        
        setupView(lightView, viewHeight: 70, hidden: hidden, animated: animated, completion: completion)
    }
    
    
    /// settingView
    func settingView(_ hidden:Bool,animated:Bool,completion:(() -> Void)?) {
        
        setupView(settingView, viewHeight: 215, hidden: hidden, animated: animated, completion: completion)
    }
    
    /// setupView frame hidden show 只适用用于底部出现的view 其他不支持 看下代码显示在使用
    func setupView(_ view:UIView,viewHeight:CGFloat,hidden:Bool,animated:Bool,completion:(() -> Void)?) {
        
        if view.isHidden == hidden {return}
        
        let animateDuration = animated ? AnimateDuration : 0
        
        let viewH:CGFloat = viewHeight
        
        if hidden {
            
            UIView.animate(withDuration: animateDuration, animations: { ()->() in
                
                view.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: viewH)
                
                }, completion: { (isOK) in
                    
                    view.isHidden = hidden
                    
                    if completion != nil {completion!()}
            })
            
        } else {
            
            view.isHidden = hidden
            
            UIView.animate(withDuration: animateDuration, animations: { ()->() in
                
                view.frame = CGRect(x: 0, y: ScreenHeight - viewH, width: ScreenWidth, height: viewH)
                
                }, completion: { (isOK) in
                    
                    if completion != nil {completion!()}
            })
        }
    }
    
    /// leftView
    func leftView(_ hidden:Bool,animated:Bool) {
        
        leftView.leftView(hidden, animated: animated)
    }

    
}


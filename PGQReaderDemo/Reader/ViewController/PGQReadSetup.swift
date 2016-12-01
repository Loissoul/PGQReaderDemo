//
//  PGQReadSetup.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

//点击手势区分

private let PGQTempW:CGFloat = ScreenWidth/3

import UIKit

class PGQReadSetup: NSObject, UIGestureRecognizerDelegate, PGQReadSettingFontViewDelegate, PGQReadSettingColorViewDelegate,PGQReadSettingFlipEffectViewDelegate, PGQReadLeftViewDelegate,PGQReadSettingFontSizeViewDeleGate {
    
    //阅读控制器
    fileprivate weak var readPageController: PGQPageViewController!
    /// UI 设置
    var readUI:PGQReadUI!

    /// 单击手势
    fileprivate var singleTap:UITapGestureRecognizer!
    
    // 当前功能view 显示状态 默认隐藏
    fileprivate var isRFHidden:Bool = true

    /// 阅读控制器设置
    class func setupWithReadController(_ readPageController:PGQPageViewController) -> PGQReadSetup {
        
        let readSetup = PGQReadSetup()
        
        readSetup.readPageController = readPageController
        
        readSetup.readUI = PGQReadUI.readUIWithReadController(readPageController)
        
        readSetup.setupSubviews()
        
        return readSetup
    }

    /// 初始化子控件相关
    func setupSubviews() {
        
        // 添加手势
        singleTap = UITapGestureRecognizer(target: self, action:#selector(PGQReadSetup.singleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        readPageController.view.addGestureRecognizer(singleTap)
        
        // 设置代理
        readUI.settingView.setColorView.aDelegate = self
        readUI.settingView.setFlipEffectView.delegate = self
        readUI.settingView.setTextFont.delegate = self
        readUI.settingView.setTextFontSize.delegate = self
        readUI.leftView.delegate = self
    }

    /// 单击手势
    func singleTap(_ tap:UITapGestureRecognizer) {
        
        let point = tap.location(in: readPageController.view)
        
        // 无效果
        if (PGQReaderConfigureManager.shareManager.flipEffect == PGQReaderFlipStyle.none || PGQReaderConfigureManager.shareManager.flipEffect == PGQReaderFlipStyle.translation) && isRFHidden  {
            
            if point.x < PGQTempW { // 左边
                
                let previousPageVC = readPageController.readConfigure.GetReadPreviousPage()
                
                if previousPageVC != nil { // 有上一页
                    
                    readPageController.coverController.setController(previousPageVC!, animated: (PGQReaderConfigureManager.shareManager.flipEffect.rawValue != 0), isAbove: true)
                    
                    // 记录
                    readPageController.readConfigure.synchronizationChangeData()
                }
                
            }else if point.x > (PGQTempW * 2) { // 右边
                
                let nextPageVC = readPageController.readConfigure.GetReadNextPage()
                
                if nextPageVC != nil { // 有下一页
                    
                    readPageController.coverController.setController(nextPageVC!, animated: (PGQReaderConfigureManager.shareManager.flipEffect.rawValue != 0), isAbove: false)
                    
                    // 记录
                    readPageController.readConfigure.synchronizationChangeData()
                }
                
            }else{ // 中间
                
                RFHidden(!isRFHidden)
            }
            
        }else{
            
            RFHidden(!isRFHidden)
        }
    }
    
    /// 隐藏显示功能view
    func RFHidden(_ isHidden:Bool) {
        
        if (isRFHidden == isHidden) {return}
        
        isRFHidden = isHidden
        
        readUI.topView(isHidden, animated: true)
        
        readUI.bottomView(isHidden, animated: true, completion: nil)
        
        if !readUI.lightView.isHidden { // 亮度view 显示着
            
            readUI.lightView(true, animated: true, completion: nil)
        }
        
        if !readUI.settingView.isHidden { // 设置view 显示着
            
            readUI.settingView(true, animated: true, completion: nil)
        }
        
        if !readUI.leftView.hidden { // 设置view 显示着
            
            readUI.leftView.clickCoverButton()
        }
    }

    // MARK: -- PGQReadLeftViewDelegate
    func readLeftView(_ readLeftView: PGQReadLeftView, clickReadChapterModel model: PGQReadChapterListModel) {
        
        setFlipEffect(PGQReaderConfigureManager.shareManager.flipEffect,chapterID: model.chapterID,chapterLookPageClear: true,contentOffsetYClear: true)
        
        RFHidden(!isRFHidden)
    }

    // MARK: -- PGQReadSettingColorViewDelegate
    func readSettingColorView(_ readSettingColorView: PGQReadSettingColorView, changReadColor readColor: UIColor) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: PGQReadBackColorChangeNoti), object: nil)
    }
    
    // MARK: -- PGQReadSettingFlipEffectViewDelegate
    func readSettingFlipEffectView(_ readSettingFlipEffectView: PGQReadSettingFlipEffectView, changeFlipEffect flipEffect: PGQReaderFlipStyle) {
        setFlipEffect(flipEffect,chapterLookPageClear: false)
    }
    
    /// 设置翻页效果
    func setFlipEffect(_ flipEffect: PGQReaderFlipStyle,chapterLookPageClear:Bool) {
        setFlipEffect(flipEffect, chapterID: readPageController.readModel.readRecord.readChapterListModel.chapterID,chapterLookPageClear:chapterLookPageClear, contentOffsetYClear: false)
    }
    
    // MARK: -- PGQReadSettingFontViewDelegate
    func readSettingFontView(_ readSettingFontView: PGQReadSettingFontView, changeFont font: PGQReaderTextFont) {
        updateFont()
    }
    
    // MARK: -- PGQReadSettingFontSizeViewDelegate
    func readSettingFontSizeView(_ readSettingFontSizeView: PGQReadSettingFOntSizeView, changeFontSize fontSize: Int) {
        
        updateFont()
    }

    /// 设置翻页效果
    func setFlipEffect(_ flipEffect: PGQReaderFlipStyle,chapterID:String,chapterLookPageClear:Bool,contentOffsetYClear:Bool) {
        
        if flipEffect != PGQReaderFlipStyle.upAndDown || contentOffsetYClear { // 上下滚动
            
            readPageController.readModel.readRecord.contentOffsetY = nil
        }
        
//        // 跳转章节
        readPageController.readConfigure.GoToReadChapter(chapterID, chapterLookPageClear: chapterLookPageClear, result: nil)
        
    }

    /// 刷新字体 字号
    func updateFont() {
        
        // 刷新字体
        readPageController.readConfigure.updateReadRecordFont()
        
        // 重新展示
        let previousPageVC = readPageController.readConfigure.GetReadViewController(readPageController.readModel.readRecord.readChapterModel!, currentPage: readPageController.readModel.readRecord.page.intValue)
        
        if (PGQReaderConfigureManager.shareManager.flipEffect == PGQReaderFlipStyle.simulation) { // 仿真
            
            readPageController.pageViewController.setViewControllers([previousPageVC], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
            
        }else{
            
            readPageController.coverController.setController(previousPageVC, animated: false, isAbove: true)
        }
    }

    

}

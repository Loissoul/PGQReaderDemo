//
//  PGQReadUtils.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit
import AdSupport

//MARK: - 屏幕

let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width

let ScreenHeight:CGFloat = UIScreen.main.bounds.height

let NavgationBarHeight:CGFloat = 64

let TabBarHeight:CGFloat = 49

let StatusBarHeight:CGFloat = 20


//MARK: - 系统判断 or 设备
let gq_4s_4:Bool = (ScreenHeight == CGFloat(480) && ScreenWidth == CGFloat(320))

let gq_5s_5:Bool = (ScreenHeight == CGFloat(568) && ScreenWidth == CGFloat(320))

let gq_6s_6:Bool = (ScreenHeight == CGFloat(667) && ScreenWidth == CGFloat(375))

let gq_6p_6sp:Bool = (ScreenHeight == CGFloat(736) && ScreenWidth == CGFloat(414))

/// iOS7 以上版本
//let iOS7:Bool = (UIDevice.current.systemVersion.doubleValue() >= 7.0)

// MARK: -- Key 值存放

/// 系统Key

/// APP版本号Key
let Key_CFBundleVersion = "CFBundleVersion"

// MARK: -- 其他全局属性 -----------------------

/// 动画时间
let AnimateDuration:TimeInterval = 0.25

/// IDFA
let HJIDFA:String = ASIdentifierManager.shared().advertisingIdentifier.uuidString


// MARK: -- 常用字体存放

let PGQFont_6:UIFont = UIFont.systemFont(ofSize: 6)
let PGQFont_10:UIFont = UIFont.systemFont(ofSize: 10)
let PGQFont_12:UIFont = UIFont.systemFont(ofSize: 12)
let PGQFont_14:UIFont = UIFont.systemFont(ofSize: 14)
let PGQFont_16:UIFont = UIFont.systemFont(ofSize: 16)
let PGQFont_18:UIFont = UIFont.systemFont(ofSize: 18)
let PGQFont_20:UIFont = UIFont.systemFont(ofSize: 20)
let PGQFont_24:UIFont = UIFont.systemFont(ofSize: 24)
let PGQFont_26:UIFont = UIFont.systemFont(ofSize: 26)

// MARK: -- 常用颜色存放 ---------------

let PGQColor_1:UIColor = RGB(68, g: 68, b: 68)
let PGQColor_2:UIColor = RGB(160, g: 160, b: 160)
let PGQColor_3:UIColor = RGB(209, g: 209, b: 209)
let PGQColor_4:UIColor = RGB(70,  g: 128, b: 227) // 主题蓝
let PGQColor_5:UIColor = RGB(245,  g: 245, b: 245) // 背景
let PGQColor_6:UIColor = RGB(240,  g: 240, b: 240) // 分割线颜色
let PGQColor_7:UIColor = RGB(216, g: 216, b: 216)
// MARK: -- 阅读页面使用颜色
let PGQColor_8:UIColor = RGB(229, g: 229, b: 229)
let PGQColor_9:UIColor = RGB(218, g: 227, b: 182)
let PGQColor_10:UIColor = RGB(200, g: 231, b: 240)
let PGQColor_11:UIColor = RGB(245, g: 214, b: 214)
let PGQColor_12:UIColor = RGB(251, g: 237, b: 199)
let PGQColor_13:UIColor = RGB(251, g: 252, b: 255)

// MARK: -- 颜色 -----------------------
/// RGB
func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return RGBA(r, g: g, b: b, a: 1.0)
}

/// RGBA
func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


// MARK: -- 高度适配使用 Screen Adaptation

func SA(_ is45:CGFloat,other:CGFloat) ->CGFloat {
    
    return SA(is45, is6: other, is6P: other)
}

func SA(_ is45:CGFloat,is6:CGFloat,is6P:CGFloat) ->CGFloat {
    
    if (gq_4s_4 || gq_5s_5) {
        
        return is45
        
    }else if gq_6s_6 {
        
        return is6
        
    }else{}
    
    return is6P
}

// MARK: -- 图书相关 ------------------

let bookWidth:CGFloat = (ScreenWidth-90)/3.0
let bookScale:CGFloat = 130.0/95.0
let bookHeight:CGFloat = bookWidth*bookScale



// MARK: -- 常用间距

/// 分割线高度
let PGQSpaceLineHeight:CGFloat = 0.5

/// 间距 10
let PGQSpaceOne:CGFloat = 10

/// 间距 15
let PGQSpaceTwo:CGFloat = 15

/// 间距 5
let PGQSpaceThree:CGFloat = 5




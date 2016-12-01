//
//  PGQReaderConfigureManager.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//


/// 阅读配置 KeyedArchiver 文件名
private let PGQReadConfigure:String = "PGQReadConfigure"

/// 颜色数组
let PGQReadColors:[UIColor] = [PGQColor_8, PGQColor_9, PGQColor_10, PGQColor_11, PGQColor_12, PGQColor_13]

/// 阅读最小阅读字体大小
let PGQReadMinFontSize:Int = 12

/// 阅读最大阅读字体大小
let PGQReadMaxFontSize:Int = 25

/// 阅读当前默认字体大小
let PGQReadDefaultFontSize:Int = 14

/// 字体颜色
let PGQReadTextColor:UIColor = RGB(68, g: 68, b: 68)

import UIKit

class PGQReaderConfigureManager: NSObject, NSCoding {
    
    /// 当前的阅读颜色
    var readColorInex:NSNumber = 4 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    // MARK: -- 阅读翻书效果
    
    /// 记录阅读翻书效果 不建议使用该值
    var flipEffectNumber:NSNumber! = 1 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    /// 阅读翻书效果
    var flipEffect:PGQReaderFlipStyle! {
        
        get{
            
            return PGQReaderFlipStyle(rawValue: flipEffectNumber.intValue) ?? PGQReaderFlipStyle(rawValue: 1)
        }
        set{
            
            flipEffectNumber = newValue.rawValue as NSNumber!
        }
    }
    
    // MARK: -- 字号
    
    /// 阅读字号
    var readFontSize:NSNumber! = PGQReadDefaultFontSize as NSNumber! {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    /// 分隔间距
    var readSpaceLineH:CGFloat = 10
    
    // MARK: -- 阅读字体
    
    /// 阅读字体颜色
    var textColor:UIColor! = PGQReadTextColor
    
    /// 记录 阅读字体 不建议使用该值
    var readFontNumber:NSNumber! = 0 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    ///  阅读字体
    var readFont:PGQReaderTextFont! {
        
        get{
            
            return PGQReaderTextFont(rawValue: readFontNumber.intValue) ?? PGQReaderTextFont(rawValue: 0)
        }
        set{
            
            readFontNumber = newValue.rawValue as NSNumber!
        }
    }
    
    // MARK: -- 亮度属性
    
    /// 记录阅读亮度模式 不建议使用该值
    var lightTypeNumber:NSNumber! = 0 {
        
        didSet{
            
            updateKeyedArchiver()
        }
    }
    
    /// 阅读亮度模式
    var lightType:PGQReaderLightStyle! {
        
        get{
            
            return PGQReaderLightStyle(rawValue: lightTypeNumber.intValue) ?? PGQReaderLightStyle(rawValue: 0)
        }
        set{
            
            lightTypeNumber = newValue.rawValue as NSNumber!
        }
    }
    
    // MARK: -- 刷新缓存
    
    /**
     刷新 KeyedArchiver
     */
    func updateKeyedArchiver() {
        
        keyArchiver(PGQReadConfigure, object: self)
    }
    
    //单例
    class var shareManager: PGQReaderConfigureManager {
        struct Static {
        
            static let instance : PGQReaderConfigureManager = PGQReaderConfigureManager.getManager()
        }
        return Static.instance
    }
    
    fileprivate class func getManager() -> PGQReaderConfigureManager {
    
        var manager: PGQReaderConfigureManager? = unArchiver(PGQReadConfigure) as? PGQReaderConfigureManager
        if manager == nil {
            manager = PGQReaderConfigureManager()
        }
        return manager!
    }
    
    override init() {
    
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        readColorInex = aDecoder.decodeObject(forKey: "readColorInex") as! NSNumber
        
        flipEffectNumber = aDecoder.decodeObject(forKey: "flipEffectNumber") as! NSNumber
        
        readFontSize = aDecoder.decodeObject(forKey: "readFontSize") as! NSNumber
        
        readFontNumber = aDecoder.decodeObject(forKey: "readFontNumber") as! NSNumber
        
        lightTypeNumber = aDecoder.decodeObject(forKey: "lightTypeNumber") as! NSNumber
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(readColorInex, forKey: "readColorInex")
        
        aCoder.encode(flipEffectNumber, forKey: "flipEffectNumber")
        
        aCoder.encode(readFontSize, forKey: "readFontSize")
        
        aCoder.encode(readFontNumber, forKey: "readFontNumber")
        
        aCoder.encode(lightTypeNumber, forKey: "lightTypeNumber")
        
    }

}





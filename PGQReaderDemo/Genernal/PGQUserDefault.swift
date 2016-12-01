//
//  PGQUserDefault.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQUserDefault: NSObject {
    
    class func UserDefaultClear() {
    
    }
    
    //删除对应key存储对象
    class func remoObjectWithKey(_ key:String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    
    // 存储object
    class func saveObjectWithKey(_ value:Any?, key:String) {
        let  defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    // String
    class func saveString (_ value:String?, key:String) {
        PGQUserDefault.saveObjectWithKey(value, key: key)
    }
    
    //NSInteger
    class func saveInteger (_ value:NSInteger, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    //Bool
    class func saveBool(_ value:Bool, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    //float
    class func saveFloat(_ value:Float, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    //Double
    class func saveDouble(_ value:Double, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    //URL
    class func saveUrl(_ value:URL, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    //--------取
    class func getObjectWithKey(_ key:String) -> Any? {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.object(forKey: key)
    }
    //String
    class func getStringWithKey(_ key:String) -> String {
        let defaults:UserDefaults = UserDefaults.standard
        let string = defaults.object(forKey: key) as? String ?? ""
        return string
    }
    //Bool
    class func getBoolWithKey(_ key:String) -> Bool {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
    //Float
    class func getFloatWithKey(_ key:String) -> Float {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.float(forKey: key)
    }
    //Double
    class func getDoubleWithKey(_ key:String) -> Double {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.double(forKey: key)
    }
    //URL
    class func getUrlWithKey(_ key:String) -> URL? {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.url(forKey: key)
    }

}


































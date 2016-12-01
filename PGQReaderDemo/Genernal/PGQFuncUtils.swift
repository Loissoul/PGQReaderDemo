//
//  PGQFuncUtils.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import Foundation

//屏幕适配 6 宽度
func width_scale(_ size:CGFloat) -> CGFloat {

    return size * (ScreenWidth / 375)
}

// 计算一般字符串
func SizeStr(_ string: String?, font:UIFont) -> CGSize {

    return Size(string, font: font, constrainedToSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
}


func Size(_ string: String?, font:UIFont, constrainedToSize:CGSize) -> CGSize {
    var tempSize = CGSize(width: 0, height:0)
    if (string != nil && !string!.isEmpty) {
        
        tempSize = string!.size(font, constrainedToSize: constrainedToSize)
    }
    return tempSize
}

//计算多态字符串
func SizeAttrStr(_ string:NSAttributedString?) -> CGSize {
    return Size(string,  constrainedToSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
}

func Size(_ string:NSAttributedString?, constrainedToSize:CGSize) -> CGSize {

    var tempSize = CGSize(width: 0 , height: 0)
    if (string != nil ) {
        tempSize = string!.size(constrainedToSize)
    }
    return tempSize
}


//时间 转换为string
func getCurrentTimeString(_ dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: Date())
}


//判断有无导航栏和工具栏 获取view的高度
func getViewHeight(_ controller:UIViewController) -> CGFloat {

    var navigationHidden = true
    var tabBarHidden = true
    if controller.navigationController != nil {
        
        navigationHidden = controller.navigationController!.isNavigationBarHidden
    }
    
    if controller.tabBarController != nil {
        tabBarHidden = controller.tabBarController!.tabBar.isHidden
    }
    
    return getViewHeight(navigationHidden, tabBarHidden: tabBarHidden)
}


//主动设置工具栏hidden 属性
func getViewHeight(_ controller: UIViewController, tabBarHidden:Bool) -> CGFloat {

    var navigationHidden = true
    if controller.navigationController != nil {
        navigationHidden = controller.navigationController!.isNavigationBarHidden
    }
    return getViewHeight(navigationHidden, tabBarHidden: tabBarHidden)
}

// 判断是否有 导航栏 计算高度
func getViewHeight (_ navigationHidden: Bool, tabBarHidden:Bool) -> CGFloat {

    var h = ScreenHeight
    if !navigationHidden {
        
        h -= NavgationBarHeight
    }
    if !tabBarHidden {
        h -= TabBarHeight
    }
    return h
}

// yyyy-mm-dd hh:mm:ss 转换为nsdate
func DateWithString(_ str:String) -> Date {

    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let timeDate = format.date(from: str)
    return timeDate!
}

//获取 yyyy-mm-dd hh:mm:ss 字符串
func DateString() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let timeDate = Date()
    return format.string(from: timeDate)
}

//手机号的判断
func CheckIsPhoneNumber(_ phoneNum:String) ->Bool {
    
    /// 手机号码
    let MOBILE:String = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    
    /// 中国移动：China Mobile
    let CM:String = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    
    /// 手机号码
    let CU:String = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    
    /// 手机号码
    let CT:String = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
    
    /// 大陆地区固话及小灵通
    // let PHS:String = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
    
    let regextestmobile:NSPredicate = NSPredicate(format: "SELF MATCHES %@", MOBILE)
    let regextestcm:NSPredicate = NSPredicate(format: "SELF MATCHES %@", CM)
    let regextestcu:NSPredicate = NSPredicate(format: "SELF MATCHES %@", CU)
    let regextestct:NSPredicate = NSPredicate(format: "SELF MATCHES %@", CT)
    let res1:Bool = regextestmobile.evaluate(with: phoneNum)
    let res2:Bool = regextestcm.evaluate(with: phoneNum)
    let res3:Bool = regextestcu.evaluate(with: phoneNum)
    let res4:Bool = regextestct.evaluate(with: phoneNum)
    
    if res1 || res2 || res3 || res4 {
        return true
    }else{
        return false
    }
}

/**
 隐藏手机号码中间的数 188*****449
 
 - parameter phoneNum: 手机号码 18812345449
 
 - returns: 处理好的手机号码 188*****449
 */
func phoneNumberEncryption(_ phoneNum:String) ->String {
    
    if CheckIsPhoneNumber(phoneNum) {
        
        let length:Int = 3 // 前后隐藏长度
        
        let strOneStart = phoneNum.characters.index(phoneNum.startIndex, offsetBy: 0)
        
        let strOneEnd = phoneNum.characters.index(phoneNum.startIndex, offsetBy: length)
        
        let strOne:String = phoneNum.substring(with: Range(strOneStart ..< strOneEnd))
        
        
        let strTwoStart = phoneNum.characters.index(phoneNum.endIndex, offsetBy: -length)
        
        let strTwoEnd = phoneNum.characters.index(phoneNum.endIndex, offsetBy: 0)
        
        let strTwo:String = phoneNum.substring(with: Range(strTwoStart ..< strTwoEnd))
        
        return strOne + "*****" + strTwo
    }
    
    return phoneNum
}


//view的 Tap 手势控制
func ViewTapGestureRecognizerEnabled(_ view:UIView, enabled:Bool) {

    if (view.gestureRecognizers != nil) {
        for ges in view.gestureRecognizers! {
            if ges.isKind(of: UITapGestureRecognizer.classForCoder()) {
                ges.isEnabled = enabled
            }
        }
    }
}

//Pan手势
func ViewPanGestureRecognizerEnabled(_ view:UIView, enabled:Bool) {

    if (view.gestureRecognizers != nil) {
        for ges in view.gestureRecognizers! {
        
            if ges.isKind(of: UIPanGestureRecognizer.classForCoder()) {
                
                ges.isEnabled = enabled
            }
        }
    }
}


//归档
func keyArchiver(_ fileName:String, object:Any) {
    
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/\(fileName)"
    NSKeyedArchiver.archiveRootObject(object, toFile: path)
    
}

//删除归档
func deleteArchiver(_ fileName: String) {
    
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/\(fileName)"
    do {
        try FileManager.default.removeItem(atPath: path)
    }catch {
    }
    
}

//解档
func unArchiver(_ fileName: String) -> Any?{
    
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/\(fileName)"
    
    return NSKeyedUnarchiver.unarchiveObject(withFile: path)
}



//创建文件夹
func createFilePath(_ filePath:String) -> Bool {
    
    let fileManager = FileManager.default
    //判断文件是否存在
    if fileManager.fileExists(atPath: filePath) {
        return true
    }
    do {
        try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil
        )
        return true
    } catch {}
    
    return false
}

//归档阅读文件
func ReadKeyArchiver(_ folderName:String, fileName:String, object:AnyObject) {

    var path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!) + "/PGQReaderDemo/PGQ\(folderName)"
    
    if (createFilePath(path)) {
        path = path + "/\(fileName)"
        NSKeyedArchiver.archiveRootObject(object, toFile: path)
    }
}

//解档文件
func ReadKeyedUnArchiver(_ folderName:String, fileName:String) -> AnyObject? {

    let  path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/PGQReaderDemo/PGQ\(folderName)" + "/\(fileName)"
    return NSKeyedUnarchiver.unarchiveObject(withFile: path) as AnyObject?
}

//删除归档文件
func RemoveReadKeyArchiver(_ folderName:String, fileName:String) {
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/PGQReaderDemo/PGQ\(folderName)" + "/\(fileName)"
    do {
        try FileManager.default.removeItem(atPath: path)
    } catch {
    }
}

//是否存在了修改的文件 
func IsExistReadArchiver(_ folderName:String, fileName:String) -> Bool {

    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String) + "/PGQReaderDemo/PGQ\(folderName)" + "/\(fileName)"
    
    return FileManager.default.fileExists(atPath: path)
    
}










































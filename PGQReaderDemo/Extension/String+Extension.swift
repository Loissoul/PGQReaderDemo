//
//  String+Extension.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import Foundation


extension String  {
    
    var length:Int {
    
        get{return (self as NSString).length}
    }
    
    func int32Value() -> Int32 {
        return NSString(string:self).intValue
    }
    
    func integeValue() -> NSInteger {
        return NSString(string:self).integerValue
    }
    
    func doubleVaue() -> Double {
        return NSString(string:self).doubleValue
    }
    
    func floatValue() -> Float {
        return NSString(string:self).floatValue
    }
    
    func CGFloatValue() -> CGFloat {
        return CGFloat(self.floatValue())
    }
    
    func substringWithRange(_ range:NSRange) -> String {
        return NSString(string:self).substring(with: range)
    }

    // 获取的字符串不带"."
    func pathExtension() -> String {
        return NSString(string:self).pathExtension
    }
    
    //获取完整的文件名 （带后缀）
    func lastPathConponent() -> String {
        return NSString(string:self).lastPathComponent
    }
    
    //不带后缀
    func stringByDeletePathExtension() -> String {
        return NSString(string:self).deletingPathExtension
    }
    
//    //字符串MD5加密
//    func md5() ->String!{
//        
//        let str = self.cString(using: String.Encoding.utf8)
//        
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        
//        for i in 0 ..< digestLen {
//            
//            hash.appendFormat("%02x", result[i])
//        }
//        
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
    
    func size(_ font:UIFont) -> CGSize {
        
        return size(font, constrainedToSize: CGSize(width:CGFloat.greatestFiniteMagnitude, height:CGFloat.greatestFiniteMagnitude))
    }
    

    func size(_ font:UIFont, constrainedToSize:CGSize) -> CGSize {
        let string:NSString = self as NSString
        
        return string.boundingRect(with: constrainedToSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil).size
    }
    
}

extension NSAttributedString {

    //计算多态字符串的size
    func size(_ constrainedToSize:CGSize?) -> CGSize {
        
        var tempConstraintedToSize = constrainedToSize
        
        if constrainedToSize == nil {
            tempConstraintedToSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        }
        return self.boundingRect(with: tempConstraintedToSize!, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], context: nil).size
    }
}




























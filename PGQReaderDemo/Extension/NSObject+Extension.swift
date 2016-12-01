//
//  NSObject+Extension.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import Foundation

extension NSObject {

    //MARK: - 对象处理
    func allPropertyNames() -> [String] {
        
        var count: UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        var propertuNames:[String] = []
        
        
        for i in 0 ..< Int(count) {
            
            let property = properties![i]
            let name = property_getName(property)
            
            let propertyName = String(cString:name!)
            propertuNames.append(propertyName)
            
        }
        free(properties)
        return propertuNames
    }
    
    func allProperties() -> [String: Any?] {
        var dict:[String : Any?] = [String : Any?]()
        
        var count: UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        for i in 0 ..< Int(count) {
        
            let property = properties![i]
            let name = property_getName(property)
            let propertyName = String(cString: name!)
            if (!propertyName.isEmpty) {
                
                let propertyValue = self.value(forKey: propertyName)
                dict[propertyName] = propertyValue
                
            }
        }

        return dict
        
    }
}

































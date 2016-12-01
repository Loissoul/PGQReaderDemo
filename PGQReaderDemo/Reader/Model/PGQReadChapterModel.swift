//
//  PGQReadChapterModel.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadChapterModel: NSObject, NSCoding {
    var chapterID: String!                 // 章节ID
    var previousChapterId: String?         // 上一章ID
    var nextChapterId:String?              // 下一章ID
    var chapterName: String!               // 章节名称
    var volumeID: String!                  // 卷ID
    var chapterContent: String! = ""       // 章节内容
    
    var pageCount:NSNumber = 0             // 本章有多少页
    var pageLocationArray:[Int] = []       // 分页的起始位置
    /// 刷新字体
    func updateFont() {
        
        pageRangeWithBounds(PGQTextParser.GetReadViewFrame())
    }
    
    func pageRangeWithBounds(_ bounds:CGRect) {
        pageLocationArray.removeAll()

        let attString = NSMutableAttributedString(string:chapterContent, attributes: PGQTextParser.parserAttribute(PGQReaderConfigureManager.shareManager))
        let frameSetter = CTFramesetterCreateWithAttributedString(attString as CFAttributedString)
        let path = CGPath(rect: bounds, transform: nil)
        var currentOffset = 0
        var currentInnerOffset = 0
        
        //是否还有更多的page
        var hasMorePages:Bool = true
        
        //
        let preventDeadLoopSign = currentOffset
        
        var samePlaceRepeatCount = 0
        
        while hasMorePages {
            
            if preventDeadLoopSign == currentOffset {
                samePlaceRepeatCount += 1
            } else {
                samePlaceRepeatCount = 0
            }
            
            if samePlaceRepeatCount > 1 {
                
                if pageLocationArray.count == 0 {
                    
                    pageLocationArray.append(currentOffset)
                    
                } else {
                    let lastOffset = pageLocationArray.last
                    
                    if lastOffset != currentOffset {
                        
                        pageLocationArray.append(currentOffset)
                    }
                }
                break
            }
            
            pageLocationArray.append(currentOffset)
            
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, nil)
            let range = CTFrameGetVisibleStringRange(frame)
            
            if (range.location + range.length) != attString.length {
                currentOffset += range.length
                currentInnerOffset += range.length
            } else {
                // 已经分完，提示跳出循环
                hasMorePages = false
            }
            pageCount = NSNumber(value:pageLocationArray.count)
        }
    }
    
    /**
     根据index 页码返回对应的字符串
     - parameter index: 页码索引
     */
    func stringOfPage(_ index:Int) ->String {
        
        let local = pageLocationArray[index]
        
        var length = 0
        
        if index < pageCount.intValue - 1 {
            
            length = pageLocationArray[index + 1] - pageLocationArray[index]
            
        } else {
            
            length = chapterContent.length - pageLocationArray[index]
        }
        
        return chapterContent.substringWithRange(NSMakeRange(local, length))
    }

    
    override init() {
    
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        chapterID = aDecoder.decodeObject(forKey: "chapterID") as! String
        
        nextChapterId = aDecoder.decodeObject(forKey: "nextChapterId") as? String
        
        previousChapterId = aDecoder.decodeObject(forKey: "previousChapterId") as? String
        
        chapterName = aDecoder.decodeObject(forKey: "chapterName") as! String
        
        volumeID = aDecoder.decodeObject(forKey: "volumeID") as! String
        
        pageCount = aDecoder.decodeObject(forKey: "pageCount") as! NSNumber
        
        pageLocationArray = aDecoder.decodeObject(forKey: "pageLocationArray") as! [Int]
        
        chapterContent = aDecoder.decodeObject(forKey: "chapterContent") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(chapterID, forKey: "chapterID")
        
        aCoder.encode(nextChapterId, forKey: "nextChapterId")
        
        aCoder.encode(previousChapterId, forKey: "previousChapterId")
        
        aCoder.encode(chapterName, forKey: "chapterName")
        
        aCoder.encode(volumeID, forKey: "volumeID")
        
        aCoder.encode(pageCount, forKey: "pageCount")
        
        aCoder.encode(pageLocationArray, forKey: "pageLocationArray")
        
        aCoder.encode(chapterContent, forKey: "chapterContent")
    }


}


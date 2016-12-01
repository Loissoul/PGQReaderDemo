//
//  PGQReadRecord.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadRecord: NSObject, NSCoding {
    /// 只有在滚动模式下才使用别的都没有用
    var contentOffsetY:NSNumber?
    
    /// 当前阅读到的章节模型
    var readChapterListModel:PGQReadChapterListModel!
    
    /// 当前阅读到的章节模型
    var readChapterModel:PGQReadChapterModel?
    
    /// 当前阅读到章节的页码
    var page:NSNumber = 0
    
    /// 当前阅读到的章节索引
    var chapterIndex:NSNumber = 0
    
    /// 总章节数
    var chapterCount:NSNumber = 0
    
    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        contentOffsetY = aDecoder.decodeObject(forKey: "contentOffsetY") as? NSNumber
        
        readChapterListModel = aDecoder.decodeObject(forKey: "readChapterListModel") as? PGQReadChapterListModel
        
        readChapterModel = aDecoder.decodeObject(forKey: "readChapterModel") as? PGQReadChapterModel
        
        page = aDecoder.decodeObject(forKey: "page") as! NSNumber
        
        chapterIndex = aDecoder.decodeObject(forKey: "chapterIndex") as! NSNumber
        
        chapterCount = aDecoder.decodeObject(forKey: "chapterCount") as! NSNumber
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(contentOffsetY, forKey: "contentOffsetY")
        
        aCoder.encode(readChapterListModel, forKey: "readChapterListModel")
        
        aCoder.encode(readChapterModel, forKey: "readChapterModel")
        
        aCoder.encode(page, forKey: "page")
        
        aCoder.encode(chapterIndex, forKey: "chapterIndex")
        
        aCoder.encode(chapterCount, forKey: "chapterCount")
    }

}

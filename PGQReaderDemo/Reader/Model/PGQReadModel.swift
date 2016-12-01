//
//  PGQReadModel.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadModel: NSObject, NSCoding {
    /// 当前的小说ID (本地小说的话 bookID就是bookName)
    var bookID:String!
    
    /// 章节列表数组
    var readChapterListModels:[PGQReadChapterListModel]!
    
    /// 阅读记录
    var readRecord:PGQReadRecord!
    
    /// 是否为本地小说
    var isLocalBook:NSNumber! = 0
    
    /// 本地小说使用 解析获得的整本字符串
    //    var content:String! = ""
    
    /// 本地小说使用 来源地址 路径
    var resource:URL?
    
    override init() {
        super.init()
        
        readChapterListModels = [PGQReadChapterListModel]()
        
        readRecord = PGQReadRecord()
    }
    
    convenience init(bookId:String, content:String) {
        self.init()
        self.bookID = bookId
        readChapterListModels = PGQTextParser.analyticString(bookId, content: content)
        
        if !readChapterListModels.isEmpty {
            
            readRecord.readChapterListModel = readChapterListModels.first
            readRecord.chapterIndex = 0
            readRecord.chapterCount = NSNumber(value:readChapterListModels.count)
            
        }
    }
    
    //本地化小说
    class func readModelWithLocalBook(_ url: URL) -> PGQReadModel {
        let bookId = PGQTextParser.GetBookName(url)

        var model = ReadKeyedUnArchiver(bookId, fileName: bookId) as? PGQReadModel
        
        if model == nil {
        
            if  url.path.lastPathConponent().pathExtension() == "txt" {
                model = PGQReadModel(bookId: bookId, content: PGQTextParser.encodeURL(url))
                model!.resource = url
                model!.isLocalBook = 1
                PGQReadModel.updateReadModel(model!)
                
                return model!
            } else {
            
                print("格式错误")
            }
        }
        
        
        return model!

    }
    
    
    //获取对应的阅读数据
    class func getReadModelWithFile(_ bookId: String) -> PGQReadModel{
        return (ReadKeyedUnArchiver(bookId, fileName: bookId) as? PGQReadModel)!
    }
    
    //刷新数据
    class func updateReadModel(_ readMOdel: PGQReadModel) {
        
        ReadKeyArchiver(readMOdel.bookID, fileName: readMOdel.bookID, object: readMOdel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        bookID = aDecoder.decodeObject(forKey: "bookID") as! String
        
        readChapterListModels = aDecoder.decodeObject(forKey: "readChapterListModels") as! [PGQReadChapterListModel]
        
        readRecord = aDecoder.decodeObject(forKey: "readRecord") as! PGQReadRecord
        
        isLocalBook = aDecoder.decodeObject(forKey: "isLocalBook") as! NSNumber
        
        resource = aDecoder.decodeObject(forKey: "resource") as? URL
    }
    func encode(with aCoder: NSCoder)  {
        aCoder.encode(bookID, forKey: "bookID")
        aCoder.encode(readChapterListModels, forKey: "readChapterListModels")
        aCoder.encode(readRecord, forKey: "readRecord")
        aCoder.encode(isLocalBook, forKey: "isLocalBook")
        aCoder.encode(resource, forKey: "resource")
    }


}




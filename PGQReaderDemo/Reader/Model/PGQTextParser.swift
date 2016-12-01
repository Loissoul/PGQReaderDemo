//
//  PGQTextParser.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

//MARK: - 边距
let PGQReadViewTopSpace:CGFloat = 40
let PGQReadViewBottonSpace:CGFloat = 40
let PGQReadViewLeftSpace:CGFloat = 20
let PGQReadViewRightSpace:CGFloat = 20
let PGQReadViewTextSpace:CGFloat = 8

//MARK: - 通知
let PGQReadBackColorChangeNoti:String = "PGQReadBackColorChangeNoti"

import UIKit

class PGQTextParser: NSObject {
    
    
    //解析本地的URL 保存阅读文件 判断是否已经有加入列表，有就不加，否则就加
    class func separateLocalURL(_ url:URL, complete:((_ isOK:Bool) -> Void)?) {
        let bookID = PGQTextParser.GetBookName(url)
        
        if !IsExistReadArchiver(bookID, fileName: bookID) {
        
            DispatchQueue.global().async {
                
                let readModel = PGQReadModel.readModelWithLocalBook(url)
                
                PGQReadModel.updateReadModel(readModel)
                
                DispatchQueue.main.async(execute: {()->() in
                    
                    if complete != nil {complete!(true)}
                })
            }
        } else{
            
            if complete != nil {complete!(false)}
        }
    }
    
    //MARK: - 正则  解析字符串
    class func analyticString(_ bookId: String, content:String) -> [PGQReadChapterListModel] {
        
        var getChapterListArr:[PGQReadChapterListModel] = []
        
        let parten = "第[0-9一二三四五六七八九十百千]*[章回].*"
        
        var results: [NSTextCheckingResult] = []
        
        do {
            let regularExpression:NSRegularExpression = try NSRegularExpression(pattern: parten, options: NSRegularExpression.Options.caseInsensitive)
            results = regularExpression.matches(in: content, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: content.length))
            
        } catch {
            
            return getChapterListArr
        }
        
        if !results.isEmpty {
            
            var lastRange = NSMakeRange(0, 0)
            for index in 0..<(results.count + 1) {
                
                let range = results[(index == results.count) ? (index - 1) : index].range
                let location = range.location
                
                //每章
                let chapterModel = PGQReadChapterModel()
                chapterModel.chapterID = "\(index + 1)"
                chapterModel.volumeID = "0"
                
                if index == 0 {
                    chapterModel.chapterName = "开始"
                    chapterModel.chapterContent = repairsContent(content.substringWithRange(NSMakeRange(0, location)))
                    
                    lastRange = range
                    
                    //如果没有内容那么跳过
                    if chapterModel.chapterContent.length == 0 {
                        continue
                    }
                } else if index == results.count { //最后一个章节
                    chapterModel.chapterName = content.substringWithRange(lastRange)
                    chapterModel.chapterContent = repairsContent(content.substringWithRange(NSMakeRange(lastRange.location, content.length - location)))
                } else {
                    //中间章节
                    chapterModel.chapterName = content.substringWithRange(lastRange)
                    chapterModel.chapterContent = repairsContent(content.substringWithRange(NSMakeRange(lastRange.location, location - lastRange.location)))
                }
                
                let readChapterListModel = getReadChapterModelListTran(chapterModel)
                
                getChapterListArr.append(readChapterListModel)
                
                //归档阅读文件
                ReadKeyArchiver(bookId, fileName: chapterModel.chapterID, object: chapterModel)
                lastRange = range
                
            }
            
        } else {
        
            let readChapterModel = PGQReadChapterModel()
            readChapterModel.chapterID = "1"
            readChapterModel.volumeID = "0"
            readChapterModel.chapterName = "开始"
            readChapterModel.chapterContent = repairsContent(content)
            
            let readChapterListModel = getReadChapterModelListTran(readChapterModel)
            
            getChapterListArr.append(readChapterListModel)
            
            //归档
            ReadKeyArchiver(bookId, fileName: readChapterModel.chapterID, object: readChapterModel)
        }
        return getChapterListArr
    }
    
    //MARK: - 小说的类型
    class func getBookFormat(_ url:URL) -> String {
        return url.path.pathExtension()
    }

    //MARK: - 获取小说的名字
    class func GetBookName(_ url:URL) -> String {
        return url.path.lastPathConponent().stringByDeletePathExtension()
    }
    
    //MARK: - 修整字符串
    class func repairsContent(_ content:String) ->String {
        
        var str = content as NSString;
        
        let spaceStr = "    "
        
        str = str.replacingOccurrences(of: "\r\n", with: "\n") as NSString
        
        str = str.replacingOccurrences(of: " ", with: "") as NSString
        
        str = str.replacingOccurrences(of: "\n", with: "\n" + spaceStr) as NSString
        
        return (spaceStr + (str as String))
    }
    
    //MARK: - 转换为list模型  PGQReadChapterListModel
    class func getReadChapterModelListTran(_ readChapterModel:PGQReadChapterModel) -> PGQReadChapterListModel {
        
        let readChapterListModel = PGQReadChapterListModel()
        
        //高度
        readChapterListModel.chapterHeight = (CGFloat(readChapterModel.pageCount.floatValue) * PGQTextParser.GetReadViewFrame().height) as NSNumber!
        
        readChapterListModel.chapterID = readChapterModel.chapterID
        readChapterListModel.volumeID = readChapterModel.volumeID
        readChapterListModel.isDownload = 1
        readChapterListModel.chapterName = readChapterModel.chapterName
        return readChapterListModel
    }
    
    //MARK: - 获取阅读view的Frame
    class func GetReadViewFrame() ->CGRect {
        
        return CGRect(x: PGQReadViewLeftSpace, y: PGQReadViewTopSpace, width: ScreenWidth - PGQReadViewLeftSpace - PGQReadViewRightSpace, height: ScreenHeight - PGQReadViewTopSpace - PGQReadViewBottonSpace)
    }
    
    //MARK: - 通过阅读模型 转换章节list模型
    class func GetReadChapterListModelTransformation(_ readChapterModel:PGQReadChapterModel) ->PGQReadChapterListModel {
        
        let readChapterListModel = PGQReadChapterListModel()
        
        // 计算高度
        readChapterListModel.chapterHeight = (CGFloat(readChapterModel.pageCount.floatValue) * PGQTextParser.GetReadViewFrame().height) as NSNumber!
        
        readChapterListModel.chapterID = readChapterModel.chapterID
        
        readChapterListModel.volumeID = readChapterModel.volumeID
        
        readChapterListModel.isDownload = 1
        
        readChapterListModel.chapterName = readChapterModel.chapterName
        
        return readChapterListModel
    }

    //MARK: - URL
    class func encodeURL(_ url:URL) -> String {
        
        var content = ""
        
        if url.absoluteString.isEmpty {
        
            return content
        }
        
        // NSUTF8 解析
        content = self.encodeURL(url,encoding: String.Encoding.utf8.rawValue)
        
        if content.isEmpty {
            content = self.encodeURL(url, encoding:0x80000632)
        }
        
        if content.isEmpty {
            
            content = self.encodeURL(url, encoding: 0x80000631)
        }
        if content.isEmpty {
            
            content = ""
        }
        
        return content
    }
    
   fileprivate class func encodeURL(_ url:URL, encoding:UInt) -> String {
    
        do {
            return try NSString(contentsOf: url, encoding:encoding) as String
        } catch  {}
        
        return ""
    }
    
    // 根据字体的类型获取字体
    class func GetReadFont(_ fontType:PGQReaderTextFont, fontSize: CGFloat) -> UIFont{
        var font:UIFont = UIFont.fontOfSize(fontSize)
        switch fontType {
        case .system:
            break
        case .black:
            font = UIFont.fontOfNameSize("EuphemiaUCAS-Italic", size: fontSize)
            break
        case .kai:
            font = UIFont.fontOfNameSize("AmericanTypewriter-Light", size: fontSize)
            break
        case .song:
            font = UIFont.fontOfNameSize("Papyrus", size: fontSize)
            break
        }
        return font
    }
    
    //MARK: - CTFrame
    class func parserRead(_ content:String, configure:PGQReaderConfigureManager, bounds:CGRect) -> CTFrame {
        
        let attributedString = NSMutableAttributedString(string:content, attributes: parserAttribute(configure))
        
        let ctFrameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        
        let path = CGPath(rect:bounds, transform:nil)
        
        let ctFrame = CTFramesetterCreateFrame(ctFrameSetter, CFRangeMake(0, 0), path, nil)
        
        return ctFrame
    }
    
    //MARK: - 获取字符串的属性
    class func parserAttribute(_ configure: PGQReaderConfigureManager) -> [String : AnyObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = configure.readSpaceLineH
        paragraphStyle.alignment = NSTextAlignment.justified
        let font = PGQTextParser.GetReadFont(configure.readFont, fontSize: CGFloat(configure.readFontSize.floatValue))
        
        let dic = [NSForegroundColorAttributeName:configure.textColor, NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle]
        
        return dic as [String : AnyObject]
    }
}






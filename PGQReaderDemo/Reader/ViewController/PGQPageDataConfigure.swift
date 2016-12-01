//
//  PGQPageDataConfigure.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQPageDataConfigure: NSObject {

    /// 阅读控制器
    fileprivate weak var readPageController:PGQPageViewController!
    
    /// 临时记录值
    var changeReadChapterModel:PGQReadChapterModel!
    var changeReadChapterListModel:PGQReadChapterListModel!
    var changeLookPage:Int = 0
    var changeChapterID:Int = 0
    
    
    //配置
    class func setupWithReadController(_ readPageController:PGQPageViewController) -> PGQPageDataConfigure {
    
        let readPageDataConfigure = PGQPageDataConfigure()
        
        readPageDataConfigure.readPageController = readPageController
        
        return readPageDataConfigure
    }
    
    //获取阅读控制器
    func GetReadViewController(_ readChapterModel:PGQReadChapterModel, currentPage:Int) -> PGQReadViewController {
    
        let readVC = PGQReadViewController()
        
        readVC.readPageController = readPageController
        
        let readCord = PGQReadRecord()
        readCord.readChapterListModel = changeReadChapterListModel
        readCord.page = NSNumber(value: currentPage)
        readCord.chapterIndex = readPageController.readModel.readRecord.chapterIndex
        readVC.readChapter = readChapterModel
        readVC.readRecord = readCord
        
        readVC.content = readChapterModel.stringOfPage(currentPage)
        
        return readVC
    }
    
    
    //外放接口
    func GoToReadChapter(_ chapterID:String,chapterLookPageClear:Bool,result:((_ isOK:Bool)->Void)?) {
        
        if !readPageController.readModel.readChapterListModels.isEmpty {
            
            let readChapterModel = GetReadChapterModel(chapterID)
            
            if readChapterModel != nil { // 有这个章节
                
                GoToReadChapter(readChapterModel!, chapterLookPageClear: chapterLookPageClear, result: result)
                
            }else{ // 没有章节
                
                if readPageController.readModel.isLocalBook.boolValue { // 本地小说
                    
                    if result != nil {result!(false)}
                    
                }else{ // 网络小说
                    
                }
            }
        }
    }

    //跳到指定的章节   阅读到的章节页码是否清0
    fileprivate func GoToReadChapter(_ readChapterModel:PGQReadChapterModel, chapterLookPageClear:Bool, result:((_ isOk:Bool)->Void)?) {
    
        changeLookPage = readPageController.readModel.readRecord.page.intValue
        
        if chapterLookPageClear {
            
            readPageController.readModel.readRecord.page = 0
            changeLookPage = 0
        }
        
        readPageController.createPageController(GetReadViewController(readChapterModel, currentPage: readPageController.readModel.readRecord.page.intValue))
        
        synchronizationChangeData()
        
        if result != nil {
            result!(true)
        }
    }
    
    // 通过章节ID获取章节模型 需要滚动到的 获取到阅读章节
    func GetReadChapterModel(_ chapterID:String) -> PGQReadChapterModel? {
        
        let pre = NSPredicate(format: "chapterID == %@",chapterID)
        
        let results = (readPageController.readModel.readChapterListModels as NSArray).filtered(using: pre)
        
        if !results.isEmpty { // 获取当前数组位置
            
            let readChapterListModel = results.first as! PGQReadChapterListModel
            
            // 获取阅读章节文件
            let readChapterModel = ReadKeyedUnArchiver(readPageController.readModel.bookID, fileName: readChapterListModel.chapterID) as? PGQReadChapterModel
            
            if readChapterModel != nil {
                
                changeReadChapterListModel = readChapterListModel
                
                changeReadChapterModel = readChapterModel
                
                // 刷新字体
                readPageController.readConfigure.updateReadRecordFont()
                
                readPageController.title = readChapterListModel.chapterName
                
                // 章节list 进行滚动
                let index = readPageController.readModel.readChapterListModels.index(of: readChapterListModel)
                
                readPageController.readModel.readRecord.chapterIndex = NSNumber(value: index!)
                
                readPageController.readSetup.readUI.leftView.scrollRow = index!
                
                readPageController.readSetup.readUI.bottomView.slider.value = Float(index!)
                
                return readChapterModel
            }
        }
        
        return nil
    }
    
    // MARK: -- 通过章节ID 获取 数组索引
    func GetReadChapterListModel(_ chapterID:String) -> PGQReadChapterListModel? {
        
        let pre = NSPredicate(format: "chapterID == %@",chapterID)
        
        let results = (readPageController.readModel.readChapterListModels as NSArray).filtered(using: pre)
        
        return results.first as? PGQReadChapterListModel
    }

    //上一页
    func GetReadPreviousPage() -> PGQReadViewController? {
        changeChapterID = readPageController.readModel.readRecord.readChapterListModel.chapterID.integeValue()
        
        changeLookPage = readPageController.readModel.readRecord.page.intValue
        
        changeReadChapterListModel = readPageController.readModel.readRecord.readChapterListModel
        
        if readPageController.readModel.isLocalBook.boolValue {
            
            if changeChapterID == 1 && changeLookPage == 0 {
                
                return nil
            }
            
            if changeLookPage == 0 {
                
                changeChapterID -= 1
                
                let readChapteModel = GetReadChapterModel("\(changeChapterID)")
                
                if readChapteModel != nil {
                    
                    //上一张
                    changeLookPage = changeReadChapterModel!.pageCount.intValue - 1
                    
                } else {
                    
                    //没有上一张
                    return nil
                }
            } else {
                
                changeLookPage -= 1
            }
        } else {
            //实时阅读
        }
        
        return GetReadViewController(changeReadChapterModel, currentPage: changeLookPage)
        
    }
    
    //下一页
    func GetReadNextPage() -> PGQReadViewController? {
        
        changeChapterID = readPageController.readModel.readRecord.readChapterListModel.chapterID.integeValue()
        
        changeLookPage = readPageController.readModel.readRecord.page.intValue
        
        changeReadChapterListModel = readPageController.readModel.readRecord.readChapterListModel
        
        if readPageController.readModel.isLocalBook.boolValue { // 本地小说
            
            if changeChapterID == readPageController.readModel.readChapterListModels.count && changeLookPage == (changeReadChapterModel.pageCount.intValue - 1) {
                
                return nil
            }
            
            if changeLookPage == (changeReadChapterModel.pageCount.intValue - 1) { // 这一章到尾部了
                
                changeChapterID += 1
                
                let chapterModel = GetReadChapterModel("\(changeChapterID)")

                if chapterModel != nil { // 有下一章
                    
                    changeLookPage = 0
                    
                }else{ // 没有下一章
                    
                    return nil
                }
                
            }else{
                
                changeLookPage += 1
            }
            
        }else{ // 网络小说阅读
            
            
        }
        
        return GetReadViewController(changeReadChapterModel, currentPage: changeLookPage)
    }
    
    
    func updateReadRecordFont() {
        
        // 刷新字体
        changeReadChapterModel.updateFont()
        
        // 重新展示
        let oldPage:Int = readPageController.readModel.readRecord.page.intValue
        
        let newPage = changeReadChapterModel.pageCount.intValue
        
        readPageController.readModel.readRecord.page = NSNumber(value: (oldPage > (newPage - 1) ? (newPage - 1) : oldPage))
        
    }

    //同步临时记录
    func synchronizationChangeData() {
        readPageController.readModel.readRecord.readChapterModel = changeReadChapterModel
        
        readPageController.readModel.readRecord.readChapterListModel = changeReadChapterListModel
        
        readPageController.readModel.readRecord.page = NSNumber(value:changeLookPage)
    }
    
    func updateReadRecord() {
        
        //同步阅读记录
        PGQReadModel.updateReadModel(readPageController.readModel)
    }
}

//
//  PGQReadViewController.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

private let PGQReadCellID:String = "PGQReadCellID"

class PGQReadViewController: PGQBaseTableViewConroller {
    
    weak var readPageController:PGQPageViewController!
    
    fileprivate var flipEffect:PGQReaderFlipStyle!   //阅读形式
    
    var  isLastPage:Bool = false //当前是否是最后一页 这一章
    
    var content:String!  //单独模式的时候显示内容
    
    var readRecord:PGQReadRecord! //阅读记录
    
    var readChapter:PGQReadChapterModel!
    
    //状态栏
    fileprivate var readBottomStatusView: PGQReadBottomStatusView!
    fileprivate var readTopStatusView:PGQReadTopStatusView!

    /// 当前滚动经过的indexPath   UpAndDown 模式使用
    fileprivate var currentIndexPath:IndexPath!
    /// 当前是往上滚还是往下滚 default: 往上
    fileprivate var isScrollTop:Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        changeBGColor()
        
        // 设置翻页方式
        changeFlipEffect()
        
//        // 设置头部名字
        readTopStatusView.setLeftTitle(readChapter.chapterName)
//
//        // 设置页码
        readBottomStatusView.setNumberPage(readRecord.page.intValue, tatolPage: readChapter.pageCount.intValue)
        
        // 通知在deinit 中会释放
        // 添加背景颜色改变通知
        NotificationCenter.default.addObserver(self, selector: #selector(PGQReadViewController.changeBGColor), name: NSNotification.Name(rawValue: PGQReadBackColorChangeNoti), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func initTableView(_ style: UITableViewStyle) {
        super.initTableView(.plain)
        
        tableView.backgroundColor = UIColor.clear
        
        tableView.frame = PGQTextParser.GetReadViewFrame()
    }
    
    override func addSubViews() {
        super.addSubViews()
        
        readTopStatusView = PGQReadTopStatusView()
        readTopStatusView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: PGQReadTopStatusViewH)
        view.addSubview(readTopStatusView)
        
        readBottomStatusView = PGQReadBottomStatusView()
        readBottomStatusView.frame = CGRect(x: 0, y: ScreenHeight - PGQReadBottomStatusViewH, width: ScreenWidth, height: PGQReadBottomStatusViewH)
        view.addSubview(readBottomStatusView)
    }

    
    /**
     获取页码
     */
    func GetCurrentPage() {
        
        if flipEffect == PGQReaderFlipStyle.upAndDown { // 滚动模式
            
            if isScrollTop {
                
                currentIndexPath = tableView.getTabelViewMinIndexPath()
                
            }else{
                
                currentIndexPath = tableView.getTableViewMaxIndexPath()
            }
            
            if  currentIndexPath != nil {
                
                let cell = tableView.cellForRow(at: currentIndexPath) as? PGQReadViewCell
                
                if cell != nil {
                    
                    let spaceH = tableView.contentOffset.y - cell!.y
                    
                    let redFrame = PGQTextParser.GetReadViewFrame()
                    
                    let page = spaceH / redFrame.height
                    
                    readPageController.readModel.readRecord.page = NSNumber(value:Int((page + 0.5)))
                    
                    readTopStatusView.setLeftTitle("\(cell!.readChapteListModel!.chapterName)")
                    
                    readPageController.readModel.readRecord.readChapterListModel = cell!.readChapteListModel
                }
            }
        }
    }
    
    
    // MARK: -- UITableViewDataSource
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        
        if flipEffect == PGQReaderFlipStyle.none { // 无效果
            
            return 1
            
        }else if flipEffect == PGQReaderFlipStyle.translation { // 平滑
            
            return 1
            
        }else if flipEffect == PGQReaderFlipStyle.simulation { // 仿真
            
            return 1
            
        }else if flipEffect == PGQReaderFlipStyle.upAndDown { // 上下滚动
            
            return 1
            
        }else{}
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if flipEffect == PGQReaderFlipStyle.none { // 无效果
            
            return 1
            
        }else if flipEffect == PGQReaderFlipStyle.translation { // 平滑
            
            return 1
            
        }else if flipEffect == PGQReaderFlipStyle.simulation { // 仿真
            
            return 1
            
        }else if flipEffect == PGQReaderFlipStyle.upAndDown { // 上下滚动
            
        }else{}
        
        return readPageController.readModel.readChapterListModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PGQReadViewCell.cellWithTableView(tableView)
        
        cell.isLastPage = isLastPage
        
        if flipEffect == PGQReaderFlipStyle.none { // 无效果
            
            cell.content = content
            
        }else if flipEffect == PGQReaderFlipStyle.translation { // 平滑
            
            cell.content = content
            
        }else if flipEffect == PGQReaderFlipStyle.simulation { // 仿真
            
            cell.content = content
            
        }else if flipEffect == PGQReaderFlipStyle.upAndDown { // 上下滚动
            
            currentIndexPath = indexPath
            
            let readChapterListModel = readPageController.readModel.readChapterListModels[indexPath.row]
            
            let tempReadChapterModel = GetReadChapterModel(readChapterListModel)
            
            cell.readChapterModel = tempReadChapterModel
            
            cell.readChapteListModel = readChapterListModel
            
            readPageController.title = readChapterListModel.chapterName
            
            // 设置页码
            readBottomStatusView.setNumberPage(indexPath.row, tatolPage: readPageController.readModel.readChapterListModels.count)
            
        }else{}
        
        
        return cell
    }
    
    // MARK: -- UITableViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        readPageController.readModel.readRecord.contentOffsetY = scrollView.contentOffset.y as NSNumber?
        
        // 判断是滚上还是滚下
        let translation = scrollView.panGestureRecognizer.translation(in: view)
        
        if translation.y > 0 {
            
            isScrollTop = true
            
        }else if translation.y < 0 {
            
            isScrollTop = false
        }
        
        // 第一种: 滚动中 更新阅读记录 以及头部名称提示
        GetCurrentPage()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        if flipEffect == PGQReaderFlipStyle.none { // 无效果
            
        }else if flipEffect == PGQReaderFlipStyle.translation { // 平滑
            
        }else if flipEffect == PGQReaderFlipStyle.simulation { // 仿真
            
        }else if flipEffect == PGQReaderFlipStyle.upAndDown { // 上下滚动
            
            let readChapterListModel = readPageController.readModel.readChapterListModels[indexPath.row]
            
            // 不要广告可注销 删除 后面 HJAdvertisementButtonH 广告高度 以及 广告距离下一章空隙
            return CGFloat(readChapterListModel.chapterHeight.floatValue) + PGQAdvertisementButtonH + PGQAdvertisementBottomSpaceH
            
        }else{}
        
        return tableView.height
    }

    /// 修改背景颜色
    func changeBGColor() {
        
        if PGQReaderConfigureManager.shareManager.readColorInex.intValue == PGQTextParser.index(ofAccessibilityElement: PGQColor_12) { // 牛皮黄
            
            let color:UIColor = UIColor(patternImage:UIImage(named: "icon_read_bg_0")!)
            readTopStatusView.backgroundColor = color
            
            view.backgroundColor = color
            
        } else {
            
            let color = PGQReadColors[PGQReaderConfigureManager.shareManager.readColorInex.intValue]
            
            readTopStatusView.backgroundColor = color
            
            view.backgroundColor = color
        }
    }

    
    /// 修改阅读方式
    func changeFlipEffect() {
        
        flipEffect = PGQReaderConfigureManager.shareManager.flipEffect
        
        if flipEffect == PGQReaderFlipStyle.none { // 无效果
            
            tableView.isScrollEnabled = false
            
        }else if flipEffect == PGQReaderFlipStyle.translation { // 平滑
            
            tableView.isScrollEnabled = false
            
        }else if flipEffect == PGQReaderFlipStyle.simulation { // 仿真
            
            tableView.isScrollEnabled = false
            
        }else if flipEffect == PGQReaderFlipStyle.upAndDown { // 上下滚动
            
            tableView.isScrollEnabled = true
            
            // 获取当前章节
            let readChapterListModel = readPageController.readConfigure.GetReadChapterListModel(readRecord.readChapterListModel.chapterID)
            
            if (readChapterListModel != nil) { // 有章节
                
                // 刷新数据
                let index = readPageController.readModel.readChapterListModels.index(of: readChapterListModel!)
                
                let _ = GetReadChapterModel(readChapterListModel!)
                
                if readPageController.readModel.readRecord.contentOffsetY != nil {
                    
                    tableView.setContentOffset(CGPoint(x: tableView.contentOffset.x, y: CGFloat(readPageController.readModel.readRecord.contentOffsetY!.floatValue)), animated: false)
                    
                }else{
                    
                    // 滚到指定章节的cell
                    tableView.scrollToRow(at: IndexPath(row: index!,section: 0), at: UITableViewScrollPosition.top, animated: false)
                    
                    // 滚动到指定cell的指定位置
                    let redFrame = PGQTextParser.GetReadViewFrame()
                    
                    tableView.setContentOffset(CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y + CGFloat(readPageController.readModel.readRecord.page.intValue) * (redFrame.height + PGQSpaceThree)), animated: false)
                }
                
                // 获取准确页面
                GetCurrentPage()
            }
            
        }else{}
    }
    
    
    /**
     获取阅读章节模型
     */
    func GetReadChapterModel(_ readChapterListModel:PGQReadChapterListModel) -> PGQReadChapterModel {
        
        // 从缓存里面获取文件
        let tempReadChapterModel = ReadKeyedUnArchiver(readPageController.readModel.bookID, fileName: readChapterListModel.chapterID) as! PGQReadChapterModel
        
        // 更新字体
        tempReadChapterModel.updateFont()
        
        // 计算高度
        //        readChapterListModel.chapterHeight = HJReadParser.parserReadContentHeight(tempReadChapterModel.chapterContent, configure: HJReadConfigureManger.shareManager, width: ScreenWidth - HJReadViewLeftSpace - HJReadViewRightSpace)
        
        readChapterListModel.chapterHeight = (CGFloat(tempReadChapterModel.pageCount.floatValue) * tableView.height) as NSNumber!
        
        return tempReadChapterModel
    }
    
    deinit{
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        readBottomStatusView.removeTimer()
    }

}

//
//  PGQReadViewCell.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/16.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

let PGQAdvertisementButtonH:CGFloat = 70
let PGQAdvertisementBottomSpaceH:CGFloat = 30


import UIKit

class PGQReadViewCell: UITableViewCell {

    var isLastPage:Bool = false
    
    var readChapteListModel:PGQReadChapterListModel?  //章节的详细信息
    
    var advertisementButton:UIButton!   //广告按钮
    
    fileprivate var readViews:[PGQReadView] = []
    
    var content:String? {
    
        didSet {
        
            if content != nil && !content!.isEmpty  {
                let readFrame = PGQTextParser.GetReadViewFrame()
                
                if PGQReaderConfigureManager.shareManager.flipEffect != PGQReaderFlipStyle.upAndDown { //不是上下滚动的时候
                
                    createReadViews(1)
                    readViews.first?.frameRef = PGQTextParser.parserRead(content!, configure: PGQReaderConfigureManager.shareManager, bounds: CGRect(x: 0, y: 0, width: readFrame.width, height: readFrame.height))
                }
                setNeedsLayout()
            }
        }
    }
    
    var readChapterModel: PGQReadChapterModel? {
    
        didSet {
        
            if readChapterModel != nil {
                if PGQReaderConfigureManager.shareManager.flipEffect == PGQReaderFlipStyle.upAndDown { //上下滚动的时候
                    
                    let reaFrame = PGQTextParser.GetReadViewFrame()
                    
                    createReadViews(readChapterModel!.pageCount.intValue)
                    
                    for i in 0..<readViews.count {
                    
                        let readView = readViews[i]
                        
                        readView.frameRef = PGQTextParser.parserRead(readChapterModel!.stringOfPage(i), configure: PGQReaderConfigureManager.shareManager, bounds: CGRect(x: 0, y: 0, width: reaFrame.width, height: reaFrame.height))
                        
                    }
                    
                    setNeedsLayout()
                }
            }
        }
    }
    
    
    //阅读的view
    fileprivate func createReadViews(_ count:NSInteger) {
        
        for i in 0..<count {
            
            let readView = PGQReadView()
            readView.tag = i
            readView.backgroundColor = UIColor.clear
            contentView.addSubview(readView)
            readViews.append(readView)
        }
    }
    
    fileprivate func removewCreateViews(_ count:NSInteger) {
    
        for readView in readViews {
            
            readView.removeFromSuperview()
        }
        readViews.removeAll()
    }
    
    class func cellWithTableView(_ tableView:UITableView) -> PGQReadViewCell {
        
        let ID = "PGQReadViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? PGQReadViewCell
        cell?.removeFromSuperview()
        cell?.readChapterModel = nil
        cell?.readChapteListModel = nil
        cell?.content = nil
        cell?.advertisementButton.isHidden = true
        if (cell == nil) {
            
            cell = PGQReadViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: ID);
        }
        
        return cell!
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier: String?) {
    
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        
        selectionStyle = UITableViewCellSelectionStyle.none
        
        layer.masksToBounds = true

        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        
        // 不要广告可注销
        advertisementButton = UIButton(type:UIButtonType.custom)
        advertisementButton.setImage(UIImage(named: "advertisementIon")!, for: UIControlState())
        advertisementButton.isHidden = true
        advertisementButton.backgroundColor = UIColor.clear
        contentView.addSubview(advertisementButton)
        advertisementButton.addTarget(self, action: #selector(PGQReadViewCell.clickAdvertisementButton), for: UIControlEvents.touchUpInside)
    }
    
    /// 点击广告
    func clickAdvertisementButton() {
        MBProgressHUD.showSuccess("点击了章节广告")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 如果不要广告的写法 取掉 AdvertisementButton 相关的  搜索 "不要广告可注销"
        if PGQReaderConfigureManager.shareManager.flipEffect == PGQReaderFlipStyle.upAndDown { // 上下滚动
            
            let redFrame = PGQTextParser.GetReadViewFrame()
            
            // 显示
            var readViewMaxY:CGFloat = 0
            
            for i in 0..<readViews.count {
                
                let readView = readViews[i];
                
                readView.frame = CGRect(x: 0, y: readViewMaxY, width: width, height: redFrame.size.height)
                
                readViewMaxY = readView.frame.maxY + PGQSpaceThree
            }
            
            advertisementButton.frame = CGRect(x: PGQSpaceTwo, y: height - PGQAdvertisementButtonH - PGQAdvertisementBottomSpaceH, width: ScreenWidth - 2*PGQSpaceTwo, height: PGQAdvertisementButtonH)
            
            advertisementButton.isHidden = false
            
        } else {
            
            readViews.first!.frame = bounds
            
            if isLastPage && content != nil && content!.length < 250 {
                
                advertisementButton.frame = CGRect(x: PGQSpaceTwo, y: height - PGQAdvertisementButtonH - 30, width: ScreenWidth - 2*PGQSpaceTwo, height: PGQAdvertisementButtonH)
                
                advertisementButton.isHidden = false
                
            } else {
                
                advertisementButton.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

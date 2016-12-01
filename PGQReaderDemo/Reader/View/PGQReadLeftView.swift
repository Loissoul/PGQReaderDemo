//
//  PGQReadLeftView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/14.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

private let TableViewW:CGFloat = ScreenWidth * 0.6

import UIKit

@objc protocol PGQReadLeftViewDelegate: NSObjectProtocol {

    @objc optional func readLeftView(_ readLeftView:PGQReadLeftView, clickReadChapterModel model:PGQReadChapterListModel)
}

class PGQReadLeftView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var hidden:Bool = false
    
    weak var delegate:PGQReadLeftViewDelegate?
    
    var dataArray:[PGQReadChapterListModel] = [] {
    
        didSet{
            tableView.reloadData()
        }
    }
    
    //文章居中
    var scrollRow:Int = 0 {
    
        didSet {
        
            tableView.scrollToRow(at: IndexPath(row: scrollRow, section: 0), at: UITableViewScrollPosition.middle, animated: false)
        }
    }
    
    
    override init() {
        super.init()
        myWindow.addSubview(coverButton)
        
        coverButton.addTarget(self, action: #selector(PGQReadLeftView.clickCoverButton), for: UIControlEvents.touchUpInside)
        
        myWindow.addSubview(tableView)
    }
    
    //MARK: - 点击消失
    func clickCoverButton(){
        leftView(true, animated: true)
    }
    
    func leftView(_ hidden:Bool, animated:Bool) {
        self.hidden = hidden
        let animateDuration = animated ? AnimateDuration: 0
        
        if hidden {
            
            UIView.animate(withDuration: animateDuration, animations: {  [weak self] ()->() in
                
                self?.tableView.frame = CGRect(x: -TableViewW, y: 0, width: TableViewW, height: ScreenHeight)
                self?.coverButton.alpha = 0
                
                }, completion: { [weak self] (isOK) in
                    
                    self?.myWindow.isHidden = hidden
            })
            
        } else {
            
            myWindow.isHidden = hidden
            
            UIView.animate(withDuration: animateDuration, animations: {[weak self] ()->() in
                
                self?.tableView.frame = CGRect(x: 0, y: 0, width: TableViewW, height: ScreenHeight)
                self?.coverButton.alpha = 0.6
                
            })
        }
    }
    deinit {
        
        myWindow.removeFromSuperview()
        coverButton.removeFromSuperview()
    }

    
    //MARK: delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PGQReadLeftViewCell.cellWithTableView(tableView)
        
        let model = dataArray[indexPath.row]
        
        cell.textLabel?.text = model.chapterName
        
        cell.textLabel?.textColor = PGQReadTextColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = PGQReadLeftHeaderView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tableView.scrollViewWillDisplayCell(cell)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataArray[indexPath.row]

        delegate?.readLeftView?(self, clickReadChapterModel: model)
    }
    
    //MARK: lazy
    lazy var tableView: PGQReaderTableView = {
        
        let tableView = PGQReaderTableView()
        
        tableView.backgroundColor = UIColor.white
        
        tableView.frame = CGRect(x: -TableViewW, y:0, width: TableViewW, height: ScreenHeight)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.showsHorizontalScrollIndicator = false
        
        return tableView
    }()
    
    fileprivate lazy var coverButton:UIButton = {
        let coverButton = UIButton(type: UIButtonType.custom)
        
        coverButton.frame = UIScreen.main.bounds
        
        coverButton.backgroundColor = UIColor.black
        
        coverButton.alpha = 0
        
        return coverButton
    }()
    
    fileprivate lazy var myWindow:UIWindow = {
        let myWindow = UIWindow(frame: UIScreen.main.bounds)
        myWindow.backgroundColor = UIColor.clear
        myWindow.isHidden = true
        myWindow.windowLevel = UIWindowLevelAlert
        return myWindow
    }()

}












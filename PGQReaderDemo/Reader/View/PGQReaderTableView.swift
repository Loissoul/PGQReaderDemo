//
//  PGQReaderTableView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReaderTableView: UITableView {

    convenience init(){
        self.init(frame:CGRect.zero)
    }
    
    convenience init(frame: CGRect) {
    
        self.init(frame: frame, style: .plain)
    }
    
    override init(frame: CGRect, style: UITableViewStyle){
    
        super.init(frame: frame, style: style)
        isHaveData = true //初始化预加载是有数据的
    }
    
    override func reloadData() {
        
        isReloadData = true
        super.reloadData()
        
        DispatchQueue.main.async { [weak self] ()->() in
            self?.isReloadData = false
        }
    }
    //获取当前最小的indexPath
    func getTabelViewMinIndexPath() -> IndexPath? {
        
        if indexPathsForVisibleRows != nil && !indexPathsForVisibleRows!.isEmpty {
            var minIndexPah:IndexPath! = indexPathsForVisibleRows!.first
            for indexPath in indexPathsForVisibleRows! {
                let result = minIndexPah.compare(indexPath) //两者相比较
                if result == ComparisonResult.orderedSame {
                
                } else if result == ComparisonResult.orderedDescending {//左边大
                    minIndexPah = indexPath
                } else if result == ComparisonResult.orderedAscending {//右边大
                } else {}
            }
            return minIndexPah
        }
        return nil
    }
    
    func getTableViewMaxIndexPath() -> IndexPath? {
        if indexPathsForVisibleRows != nil && !indexPathsForVisibleRows!.isEmpty {
            var maxIndexPah:IndexPath! = indexPathsForVisibleRows!.first
            for indexPath in indexPathsForVisibleRows! {
                let result = maxIndexPah.compare(indexPath) //两者相比较
                if result == ComparisonResult.orderedSame {
                    
                } else if result == ComparisonResult.orderedDescending {//左边大
                } else if result == ComparisonResult.orderedAscending {//右边大
                    maxIndexPah = indexPath
                } else {}
            }
            return maxIndexPah
        }
        return nil
    }
    
    //是否开启拦截当前父视图的touch事件 
    var openTouch: Bool = false
    
    //当多个滚动控件控件一起使用的时候 开始手势拦截 开启之后当前滚动控件上的子控件手势 父滚动也会触发使用
    var openIntercept:Bool = false

    func getureRecognizer(_ gestureRecognizer: UIGestureRecognizer, otherRecognizer: UIGestureRecognizer) -> Bool {
        
        if openIntercept && gestureRecognizer.state != .possible {
            
            return true
        }
        return false
    }

    //响应者拦截
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if openTouch {
            next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if openTouch {
            
            next?.touchesMoved(touches, with: event)
            
        }else{
            
            super.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if openTouch {
            
            next?.touchesEnded(touches, with: event)
            
        }else{
            
            super.touchesEnded(touches, with: event)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}






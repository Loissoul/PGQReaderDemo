//
//  PGQReadTopStatusView.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/14.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

let PGQReadTopStatusViewH:CGFloat = 40

import UIKit

class PGQReadTopStatusView: UIView {

    fileprivate var leftTitle:UILabel!
    
    override init(frame:CGRect) {
    
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        createView()
    }
    
    //设置标题
    func setLeftTitle(_ title:String?) {
        self.leftTitle.text = title
    }
    
    func createView() {
        
        leftTitle = UILabel()
        leftTitle.textColor = PGQReadTextColor
        leftTitle.font = UIFont.fontOfSize(12)
        leftTitle.textAlignment = .left
        addSubview(leftTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftTitle.frame = CGRect(x: PGQSpaceTwo, y: 3, width: width - 2*PGQSpaceTwo, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

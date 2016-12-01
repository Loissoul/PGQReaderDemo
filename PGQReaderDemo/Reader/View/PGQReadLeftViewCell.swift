//
//  PGQReadLeftViewCell.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/15.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQReadLeftViewCell: UITableViewCell {

    var spaceLine: UIView!
    
    class func cellWithTableView(_ tableView:UITableView) -> PGQReadLeftViewCell {
        
        let ID = "PGQReadLeftCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? PGQReadLeftViewCell
        
        if (cell == nil) {
        
            cell = PGQReadLeftViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier: ID)
            
        }
        return cell!
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
    
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.fontOfSize(16)
        selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    func createView() {
        spaceLine = SetUpViewLine(contentView, color: PGQColor_6)
        spaceLine.frame = CGRect(x: 0, y: height - PGQSpaceLineHeight, width: width, height: PGQSpaceLineHeight)

    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

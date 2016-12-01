//
//  PGQBaseTableViewConroller.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit

class PGQBaseTableViewConroller: PGQBaseReadViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView:PGQReaderTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addSubViews() {
        super.addSubViews()
        initTableView(.grouped)
    }
    
    func initTableView(_ style:UITableViewStyle) {
        
        tableView = PGQReaderTableView(frame: CGRect(x: 0, y: NavgationBarHeight, width: ScreenWidth, height: getViewHeight(false, tabBarHidden: true)), style: style)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.scrollViewWillDisplayCell(cell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath )
        return cell
    }

}





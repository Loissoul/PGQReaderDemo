//
//  PGQReaderStyleEnum.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/11.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import Foundation

//亮度模式
enum PGQReaderLightStyle:Int {
    case day
    case night
}

//翻页效果
enum PGQReaderFlipStyle:Int {
    case none            //没有效果
    case translation     //平移
    case simulation      //仿真
    case upAndDown       //上下
}

//阅读字体
enum PGQReaderTextFont:Int {

    case system
    case black
    case song
    case kai
}

//加载章节方式
enum PGQReaderLoadType {

    case none
    case next
    case before
}

//
//  GlobalFile.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import Foundation
import UIKit


/// 全局背景
let Color_GlobalBackground = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
let Color_GlobalLine = UIColor(red: 237.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
let Color_NavBackground = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)

let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

func viewHeight(view: UIView) -> CGFloat {
    return view.frame.size.height
}

func viewWidth(view: UIView) -> CGFloat {
    return view.frame.size.width
}

func viewX(view: UIView) -> CGFloat {
    return view.frame.origin.x
}

func viewY(view: UIView) -> CGFloat {
    return view.frame.origin.y
}


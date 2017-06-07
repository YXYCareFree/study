//
//  MaskCoverView.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

private var hideBlock: (()->())?
class MaskCoverView: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

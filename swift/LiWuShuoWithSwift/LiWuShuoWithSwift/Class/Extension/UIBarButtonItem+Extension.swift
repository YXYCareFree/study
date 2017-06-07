//
//  UIBarButtonItem+Extension.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    //礼物
    convenience init(giftTarget: AnyObject?, action: Selector) {

        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: "feed_signin"), forState: UIControlState.Normal)
        btn.frame = CGRectMake(0, 0, 44, 44)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btn.addTarget(giftTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
    }

    //搜索
    convenience init(searchTarget: AnyObject?, action: Selector) {

        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: "icon_navigation_search"), forState: UIControlState.Normal)
        btn.frame = CGRectMake(0, 0, 44, 44)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        btn.addTarget(searchTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
    }

    //选礼神器
    convenience init(chooseGiftTarget: AnyObject?, action: Selector) {

        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRectMake(0, 0, 60, 44)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        btn.setTitle("选礼神器", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.addTarget(chooseGiftTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)

    }
}

//
//  NavigationController.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.delegate = nil

        let appearance = UINavigationBar.appearance()
        appearance.translucent = false
        appearance.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), size: CGSizeMake(1, 1)), forBarMetrics: UIBarMetrics.Default)

        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.whiteColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(16)

        appearance.titleTextAttributes = textAttrs
    }

    lazy var backBtn: UIButton = UIButton(backTarget: self, action: #selector(NavigationController.backBtnAction))

    func backBtnAction(){

        self.popViewControllerAnimated(true)
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {

        if self.childViewControllers.count > 0 {

            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }

        super.pushViewController(viewController, animated: true)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

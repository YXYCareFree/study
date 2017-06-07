//
//  TabBarController.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }

    func addChildViewControllers(){
        
        //如果没有图片的话title显示不出来
        addChildViewController(HomeViewController(), title: "礼物说", imageName: "tabbar_home")
        addChildViewController(HotViewController(), title: "热门", imageName: "tabbar_gift")
        addChildViewController(ClassifyViewController(), title: "分类", imageName: "tabbar_category")
        addChildViewController(MeViewController(), title: "我的", imageName: "tabbar_me")
    }
    
    func addChildViewController(controller: UIViewController, title: String, imageName: String) {

        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        controller.tabBarItem.title = title

        let nav = NavigationController()
        nav.addChildViewController(controller)
        addChildViewController(nav)

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

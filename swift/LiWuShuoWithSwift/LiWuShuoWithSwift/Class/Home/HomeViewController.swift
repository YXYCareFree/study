//
//  HomeViewController.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var  categoryTitles: [NSString]{

        return ["精选", "海淘", "创意生活", "送女票", "送爸妈", "科技范", "送基友", "送闺蜜", "送同事", "送宝贝", "设计感", "文艺范", "奇葩搞怪", "萌萌哒"]
    }

    var cacheCategoryViews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIFrame()
    }

   private func setupUI(){

    view.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)

    navigationItem.leftBarButtonItem = UIBarButtonItem(giftTarget: self, action: #selector(HomeViewController.giftBtnAction))

    navigationItem.title = "礼物说"
    }

   private func setupUIFrame(){

  
    }
    //MARK:--事件
    @objc private func searchBtnAction(){

        navigationController?.pushViewController(self, animated: true)
    }

    @objc private func giftBtnAction(){

    NSNotificationCenter.defaultCenter().postNotificationName("", object: nil)
    }

    //MARK:懒加载
    private lazy var titleImageView:UIImageView = {

        let image = UIImage(named: "logo")
        let titleImageView = UIImageView(image: image)
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        titleImageView.bounds = CGRectMake(0, 0, 20 * (image!.size.width / image!.size.height), 20)
        return titleImageView
    }()

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

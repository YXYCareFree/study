//
//  ViewController.swift
//  SimpleSwift
//
//  Created by beyondSoft on 16/6/28.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = UIColor.red
        imageView.frame = CGRect(x: 60, y: 60, width: 100, height: 100)

        view.addSubview(imageView)

        let i = CGFloat(UIScreen.main.bounds.size.height)
        print(i)
        performSelector(onMainThread: #selector(function), with: nil, waitUntilDone: false)
    }
    func function() {

        let p = Person.init(name: "zhaosi", age: 10)
        
        print(p, p.age)
        p.name = "name"
        if let str = p.name {
            print("p.name:\(str)")
        }


//        let p1 = Person()
//        p1.name = "liuneng"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.detailTextLabel!.text = "Cell Detail"
        cell.textLabel!.text = "cell text"
        cell.imageView!.image = UIImage(named: "")
        return cell
    }

}


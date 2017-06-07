//
//  ViewController.swift
//  UITableViewWithSwift
//
//  Created by beyondSoft on 16/7/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func  tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!CustomCell
        cell.textLabel?.text = String(indexPath.row)
        return cell

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


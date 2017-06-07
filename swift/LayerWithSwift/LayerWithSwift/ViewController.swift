//
//  ViewController.swift
//  LayerWithSwift
//
//  Created by beyondSoft on 16/7/13.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

      let layer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()


        layer.strokeEnd = 0
        layer.lineWidth = 6
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(layer)
    }

    @IBAction func actionToAnimate() {
        layer.path = UIBezierPath(arcCenter: self.view.center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true).CGPath
        layer.strokeEnd = 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


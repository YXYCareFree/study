//
//  Person.swift
//  SimpleSwift
//
//  Created by 杨肖宇 on 2017/5/22.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

import UIKit

class Person: NSObject {

    var name : String?
//    {
//       
//        willSet(new){
//            print(new!)
//            print(name)
//        }
//        
//        didSet(old){
//            if name != nil {
//                print(name!)
//            }
//            if old != nil {
//                print(old!)
//            }
//        }
//    }
    var age : Int 
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    
    
}

//
//  main.swift
//  TestSwift
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import Foundation

print("Hello, World!")

var nameArr = ["111"]
print("nameArr=\(nameArr)")

nameArr.removeAll()
nameArr.append("222")
print("nameArr=\(nameArr)")

nameArr.append("333")
print("nameArr=\(nameArr)")

for name in nameArr{
    print("name=\(name)")
}

var ageArr = [111, 222, 333]
print("ageArr=\(ageArr)")
for age in ageArr{
    print("age=\(age)")
}


let haidian = "海淀"
print("haidian=\(haidian)")

var hai = "hello word!"
print("hai=\(hai)")

var dict = ["age":12, "name":"zhangsan"]
print("dict=\(dict)")

dict["age"] = 33
print("dict=\(dict)")


var string: String? = "hello"//后面加问号标明是可选的，这样下面的if语句才不会报错
if let name = string {
    print("\(string)")
}else{
    print("nil")
}

let name = "name"
switch name {
    case "name":
    print("correct")
default:
    print("error")
}



//
//  MacroDefinition.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/12/9.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//MARK: - 系统版本
let kIOS7 = (UIDevice().systemVersion as NSString).doubleValue >= 7.0 ? 1 :0
let kIOS8 = (UIDevice().systemVersion as NSString).doubleValue >= 8.0 ? 1 :0

let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width

//MARK: - 颜色
func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}




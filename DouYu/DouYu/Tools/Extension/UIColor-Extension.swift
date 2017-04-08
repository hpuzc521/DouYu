//
//  UIColor-Extension.swift
//  DouYu
//
//  Created by zc on 2017/4/6.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func mixColor(sourceColor: UIColor, targetColor: UIColor, ratio: CGFloat) -> UIColor{
        var rat = ratio
        if rat > 1 { rat = 1 }
        if rat < 0 { rat = 0 }
        
        let components1 = UIColor.getRGB(color: sourceColor)
        let components2 = UIColor.getRGB(color: targetColor)
        
        let r = components2[0] * rat + components1[0] * (1 - rat)
        let g = components2[1] * rat + components1[1] * (1 - rat)
        let b = components2[2] * rat + components1[2] * (1 - rat)
        
        return UIColor(r: r, g: g, b: b)
    }
    
    class func getRGB(color: UIColor) -> [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return [red * 255, green * 255, blue * 255, alpha]
    }
}

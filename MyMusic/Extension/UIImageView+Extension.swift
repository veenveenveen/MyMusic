//
//  UIImageView+Extension.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

extension UIImageView {
    func setBorder(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
    }
}

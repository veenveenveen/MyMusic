//
//  QMMusicModel.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class QMMusicModel: NSObject {
    
    //歌曲名称
    var name: String?
    //音乐文件名
    var filename: String?
    //歌词文件名
    var lrcname: String?
    //歌手名
    var singer: String?
    //歌手图标
    var icon: String?
    //歌手写真
    var singerImg: String?
    
    func modelWith(dict: [String: AnyObject]) {
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
}

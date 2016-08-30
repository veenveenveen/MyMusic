//
//  QMMusicTool.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class QMMusicTool: NSObject {
    
    static var playingMusic: QMMusicModel?
    
    //返回所有的歌曲
    static var musics: Array<QMMusicModel> = {
        let musicPath = NSBundle.mainBundle().pathForResource("Music", ofType: ".plist")
        let arr = NSArray(contentsOfFile: musicPath!)
        var array = Array<QMMusicModel>()
        for a in arr! {
            let model = QMMusicModel()
            model.modelWith(a as! [String : AnyObject])
            array.append(model)
        }
        return array
    }()
    //返回正在播放的歌曲
    static func getCurrentMusic() -> QMMusicModel? {
        guard playingMusic != nil else {
            return nil
        }
        return playingMusic!
    }
    //下一首歌曲
    static func getNextMusic() -> QMMusicModel? {
        guard playingMusic != nil else {
            return nil
        }
        let index = musics.indexOf(playingMusic!)
//        print(index)
        var nextIndex = index! + 1
        if nextIndex >= musics.count {
            nextIndex = 0
        }
//        print(nextIndex)
        return musics[nextIndex]
    }
    //上一首歌曲
    static func getPreviousMusic() -> QMMusicModel? {
        guard playingMusic != nil else {
            return nil
        }
        let index = musics.indexOf(playingMusic!)
        var previousIndex = index! - 1
        if previousIndex < 0 {
            previousIndex = musics.count - 1
        }
        return musics[previousIndex]
    }
    
}

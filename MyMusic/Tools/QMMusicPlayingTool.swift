//
//  QMMusicPlayingTool.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import AVFoundation

class QMMusicPlayingTool: NSObject {

    static var player: AVAudioPlayer?
    
    //用于判断是否正在播放
    static var isPlaying: Bool = false
    
    //播放音乐
    static func playMusic(fileName: String?) {
        guard fileName != nil else {
            return
        }
        if player == nil {
            let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
            //创建播放器
            player = try? AVAudioPlayer(contentsOfURL: url!)
            player?.prepareToPlay()
        }
            player?.play()
    }
    //暂停播放
    static func pauseMusic(fileName: String?) {
        guard fileName != nil else {
            return
        }
        player?.pause()
    }
    //停止播放
    static func stopMusic(fileName: String?) {
        guard fileName != nil else {
            return
        }
        player?.stop()
    }
}

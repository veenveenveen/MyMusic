//
//  QMMusicViewController.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import AVFoundation

protocol backButtonDelegate {
    func refreshData()
}

class QMMusicViewController: UIViewController, AVAudioPlayerDelegate {
//MARK: - 属性
    
    //刷新数据代理
    var delegate: backButtonDelegate?
    
    var window: UIWindow?
    
    //进度条 滑块 歌曲时长 当前播放时长
    @IBOutlet weak var progressBackground: UIView!
    @IBOutlet weak var currentProgress: UIImageView!
    @IBOutlet weak var durationLable: UILabel!
    @IBOutlet weak var currentLable: UILabel!
        
    //定时器
    var timer: NSTimer?
    
    //歌曲信息
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var singer: UILabel!
    @IBOutlet weak var singerImg: UIImageView!
    //播放/暂停 按钮
    @IBOutlet weak var playBtn: UIButton!
    
    //用于判断是不是正在播放的音乐 用于检测是否换了歌曲
    var isPlayingMusic: QMMusicModel?
    
    //定义一个数组 用于保存加入“喜欢”的歌曲
    var likeArrar = Array<QMMusicModel>()
    //喜欢/不喜欢标签
    @IBOutlet weak var likeButton: UIButton!
    //是否喜欢 用于判断
    var islike: Bool = false
    
    //词图
    @IBOutlet weak var lyricButton: UIButton!
    var islyric: Bool = false
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        window = UIApplication.sharedApplication().keyWindow
        view.frame = (window?.bounds)!
        view.frame.origin.y = (window?.bounds.size.height)!
        window?.addSubview(view)
        view.alpha = 0
        QMMusicPlayingTool.setAudioSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK: - 展示当前播放界面的方法
    func showView() {
        window?.userInteractionEnabled = false
        self.view.hidden = false
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.alpha = 1
            self.view.frame.origin.y = 0
            }) { (finished) in
                self.window?.userInteractionEnabled = true
        }
        //检查是否换了歌曲
        if isPlayingMusic != QMMusicTool.playingMusic {
            //如果换了 清空信息
            cleanPlayer()
            removeTimer()
            play(QMMusicTool.getCurrentMusic()?.filename)
            
        }
    }
//MARK: - 清空播放器
    func cleanPlayer() {
        QMMusicPlayingTool.player = nil
    }
//MARK: - 返回按钮，播放/暂停，上一曲，下一曲 按钮点击事件
    @IBAction func backBtn(sender: AnyObject) {
        
        window?.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.alpha = 0
            self.view.frame.origin.y = screenH
        }) { (finished) in
            self.window?.userInteractionEnabled = true
            self.view.hidden = true
        }
        //设置代理 刷新列表
        delegate?.refreshData()
    }

    func play(filename: String?) {
        QMMusicPlayingTool.playMusic(filename)
        //设置player 的代理 播放完成之后。。。
        QMMusicPlayingTool.player?.delegate = self
        QMMusicPlayingTool.isPlaying = true
        playBtn.setImage(UIImage(named: "start"), forState: .Normal)
        
        
        //设置数据
        setDataForMusicViewWith(QMMusicTool.getCurrentMusic()!)
        //添加定时器
        addTimer()
}
    
    @IBAction func playClick(sender: AnyObject) {
        //播放和暂停的时候不设置数据
        if !QMMusicPlayingTool.isPlaying {
        QMMusicPlayingTool.playMusic(QMMusicTool.getCurrentMusic()?.filename)
            QMMusicPlayingTool.isPlaying = true
            addTimer()
            playBtn.setImage(UIImage(named: "start"), forState: .Normal)
        }
        else if QMMusicPlayingTool.isPlaying {
        QMMusicPlayingTool.pauseMusic(QMMusicTool.getCurrentMusic()?.filename)
            removeTimer()
            QMMusicPlayingTool.isPlaying = false
            playBtn.setImage(UIImage(named: "Pause"), forState: .Normal)
        }
    }
    //下一首
    @IBAction func nextClick(sender: AnyObject) {
        let nextMusic = QMMusicTool.getNextMusic()
        QMMusicTool.playingMusic = nextMusic
        //歌曲改变 清空信息
        QMMusicPlayingTool.player = nil
        play(nextMusic?.filename)
    }
    //上一首
    @IBAction func previousClick(sender: AnyObject) {
        let previousMusic = QMMusicTool.getPreviousMusic()
        QMMusicTool.playingMusic = previousMusic
        //歌曲改变 清空信息
        QMMusicPlayingTool.player = nil
        play(previousMusic?.filename)
    }
    //设置数据
    func setDataForMusicViewWith(music: QMMusicModel) {
        name.text = music.name
        singer.text = music.singer
        singerImg.image = UIImage(named: music.singerImg!)
        //用于记录歌曲刚才播放的歌曲
        isPlayingMusic = music
        //显示时长
        durationLable.text = stringWith((QMMusicPlayingTool.player?.duration)!)
        if likeArrar.contains(QMMusicTool.getCurrentMusic()!) {
            likeButton.setImage(UIImage(named: "like"), forState: .Normal)
            islike = true
        }
        else {
            likeButton.setImage(UIImage(named: "unlike"), forState: .Normal)
            islike = false
        }
    }
//MARK: - 定时器
    //将时长转换为字符串
    func stringWith(time: NSTimeInterval) -> String {
        let min = time / 60
        let second = time % 60
        return NSString(format: "%02d:%02d", Int(min),Int(second)) as String
    }
    //添加定时器
    func addTimer() {
        updateCurrentTime()
        timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    //移除定时器
    func removeTimer() {
        timer?.invalidate()
        //清空定时器
        timer = nil
    }
    //更新当前播放时间
    func updateCurrentTime() {
        currentLable.text = stringWith((QMMusicPlayingTool.player?.currentTime)!)
        currentProgress.frame.size.width = CGFloat((QMMusicPlayingTool.player?.currentTime)!) / CGFloat((QMMusicPlayingTool.player?.duration)!) * progressBackground.frame.size.width
    }
//MARK: - 进度条
    //进度条点击手势
    @IBAction func touchPregress(sender: UIGestureRecognizer) {
        //获取点击的点
        let point = sender.locationInView(sender.view)
        //改变歌曲的当前播放时间
        QMMusicPlayingTool.player?.currentTime = Double((point.x / (sender.view?.frame.size.width)!)) * (QMMusicPlayingTool.player?.duration)!
        //更新currentLable
        updateCurrentTime()
    }
//    @IBAction func panSlider(sender: UIPanGestureRecognizer) {
//        //获取点
//        let point = sender.locationInView(sender.view)
//        sender.setTranslation(CGPointZero, inView: sender.view)
//        let x = point.x
//        
//        sliderButton.frame.origin.x = x
//        progressView.frame.size.width = point.x
//        
//        
//        
//    }
//MARK: - AVAudioPlayer 代理方法
    //播放完成之后
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        nextClick(player)
    }
    //被打断
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        if QMMusicPlayingTool.isPlaying {
            QMMusicPlayingTool.pauseMusic(isPlayingMusic?.filename)
        }
    }
    //结束被打断
    func audioPlayerEndInterruption(player: AVAudioPlayer, withFlags flags: Int) {
    }
//MAEK: - 后台播放处理
    //在 AppDelegate 中
//MARK: - like标签
    //likeButtonClick
    @IBAction func likeButtonClick(sender: AnyObject) {
        turnLike()
    }
    func turnLike() {
        if islike {
            likeButton.setImage(UIImage(named: "unlike"), forState: .Normal)
            let index = likeArrar.indexOf(QMMusicTool.getCurrentMusic()!)
            likeArrar.removeAtIndex(index!)
            islike = false
//            print(likeArrar)
        }
        else if !islike {
            likeButton.setImage(UIImage(named: "like"), forState: .Normal)
            islike = true
            likeArrar.append(QMMusicTool.getCurrentMusic()!)
//            print(likeArrar)
        }
    }
//MARK: - 歌词
    //lyricButton 点击事件
    @IBAction func lyricButtonClick(sender: AnyObject) {
        if islyric {
            lyricButton.setImage(UIImage(named: "tu"), forState: .Normal)
            islyric = false
        }
        else {
            lyricButton.setImage(UIImage(named: "ci"), forState: .Normal)
            islyric = true
        }
    }
}

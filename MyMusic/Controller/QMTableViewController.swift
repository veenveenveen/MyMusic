//
//  QMTableViewController.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class QMTableViewController: UITableViewController {
    
    
    //从plist文件中读取 字典转模型 保存每一首歌曲的信息
    var musics = QMMusicTool.musics
    
    lazy var musicViewController: QMMusicViewController = {
        let musicVW = QMMusicViewController(nibName: "QMMusicViewController", bundle: nil)
        musicVW.view.frame = CGRectMake(0, screenH, screenW, screenH)
        return musicVW
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    //设置tableView属性
    func setTableView() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view 数据源和代理方法
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musics.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("music_cell", forIndexPath: indexPath) as! QMTableViewCell
        cell.setMusicDataWith(musics[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //设置行高
        return 70
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取消选中的这行
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //设置当前正在播放的歌曲
        QMMusicTool.playingMusic = musics[indexPath.row]
        
        //显示播放界面(同时播放选中的歌曲)
        musicViewController.showView()
    }
    
    

}

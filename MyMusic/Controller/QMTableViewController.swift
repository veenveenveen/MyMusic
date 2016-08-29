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
    lazy var musics: Array<QMMusicModel> = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for a in musics {
//            print(a.name)
//            print(a.filename)
//            print(a.lrcname)
//            print(a.singer)
//            print(a.icon)
//        }
        setTableView()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setTableView() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("music_cell", forIndexPath: indexPath) as! QMTableViewCell
        cell.setMusicData(musics[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //设置行高
        return 70
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取消选中的这行
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

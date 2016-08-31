//
//  QMLyricView.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/31.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class QMLyricView: UIView, UITableViewDelegate, UITableViewDataSource {

    var tabView: UITableView?
    
    var lyricname: String?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        hidden = true
        tabView = UITableView()
        tabView?.delegate = self
        tabView?.dataSource = self
        addSubview(tabView!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tabView?.dequeueReusableCellWithIdentifier("table_cell")
        return cell!
        
    }

}

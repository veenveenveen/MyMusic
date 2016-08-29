//
//  QMTableViewCell.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class QMTableViewCell: UITableViewCell {
    @IBOutlet weak var singleIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var singer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clearColor()
        setIcon()
        
    }
    
    func setIcon() {
        singleIcon.setBorder(20, borderWidth: 1, borderColor: UIColor.brownColor())
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - 设置数据
    func setMusicData(music: QMMusicModel) {
        singleIcon.image = UIImage(named: music.icon!)
        name.text = music.name
        singer.text = music.singer
    }

}

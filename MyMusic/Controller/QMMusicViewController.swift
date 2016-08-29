//
//  QMMusicViewController.swift
//  MyMusic
//
//  Created by 黄启明 on 16/8/29.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class QMMusicViewController: UIViewController {

    var window: UIWindow?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        window = UIApplication.sharedApplication().keyWindow
        view.frame = (window?.bounds)!
        view.frame.origin.y = (window?.bounds.size.height)!
        window?.addSubview(view)
        view.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showView() {
        
        window?.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.alpha = 1
            self.view.frame.origin.y = 0
            }) { (finished) in
                self.window?.userInteractionEnabled = true
        }
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        
        window?.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.alpha = 0
            self.view.frame.origin.y = (self.window?.bounds.size.height)!
        }) { (finished) in
            self.window?.userInteractionEnabled = true
        }
    }

}

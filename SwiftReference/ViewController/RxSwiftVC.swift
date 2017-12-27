//
//  RxVC.swift
//  SwiftReference
//
//  Created by baw0803 on 2017. 10. 23..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import AlamofireImage

class RxSwiftVC: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btn1.af_setBackgroundImage(for: .normal, url: URL(string: "http://pocimg-c.skmcgw.com/upload/feed/feed_20170717145432_40265062.png")!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

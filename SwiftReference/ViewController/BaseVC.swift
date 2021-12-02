//
//  BaseVC.swift
//  SwiftReference
//
//  Created by sungwook on 2021/12/02.
//  Copyright © 2021 wooky83. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}

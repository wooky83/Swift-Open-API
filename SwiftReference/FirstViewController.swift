//
//  FirstViewController.swift
//  SwiftReference
//
//  Created by wooky83 on 2017. 10. 18..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Result

class FirstViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let hi: Result<String, NSError> = Result("xx")
        switch hi {
        case .success(let x):
            print("why:\(x)")
        case .failure(let err):
            print(err)
        }
        let dd = DisposeBag()
        button.rx.tap.subscribe {
            print("dfjkldfjdlkfj")
            }.disposed(by: dd)
        
        button.rx.tap.bind {
            print("xxxx")
            }.dispose()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


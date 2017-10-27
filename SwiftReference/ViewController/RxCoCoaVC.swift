//
//  RxCoCoaVC.swift
//  SwiftReference
//
//  Created by baw0803 on 2017. 10. 23..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxCoCoaVC: UIViewController {
    
    @IBOutlet weak var idTextF: UITextField!
    @IBOutlet weak var passwordTextF: UITextField!
    @IBOutlet weak var joinBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let idObj = idTextF.rx.text.asObservable().map{!(($0?.isEmpty)!)}
        idObj.subscribe(onNext: {
                self.idTextF.backgroundColor = $0 ? UIColor.green : UIColor.red
            
            }).disposed(by: disposeBag)
        
        let pwObj = passwordTextF.rx.text.asObservable().map{!(($0?.isEmpty)!)}
        
        Observable.combineLatest(idObj, pwObj) {
            return ($0, $1)
            }.subscribe {
                switch $0 {
                case .next(true, true):
                    print("111")
                case .next(true, _):
                    print("222")
                case .next(_, true):
                    print("333")
                case .next(_, _):
                    print("444")
                default:()
                }
        }.disposed(by: disposeBag)
        
        joinBtn.rx.tap.subscribe { _ in print("buttonTap")}.disposed(by: disposeBag)        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

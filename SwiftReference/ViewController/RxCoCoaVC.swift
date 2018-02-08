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
    @IBOutlet weak var bindTextF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
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
                print("Look")
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
        
        let xx: String? = "1"
        print(String(describing:xx))
        
        bindTextF.rx.text.map { arg in
            print(String(describing:arg))
            return "\(arg!) : whyNot"
            }.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//
//  SubjectsVC.swift
//  SwiftReference
//
//  Created by baw0803 on 2018. 3. 6..
//  Copyright © 2018년 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectsVC: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let publish = PublishSubject<Int>()
        publish.onNext(1)
        publish.onNext(2)
        publish.subscribe {
            print("publishSubject : \($0)")
        }.disposed(by: disposeBag)
        publish.onNext(3)
        publish.onNext(4)
        
        let replay = ReplaySubject<Int>.create(bufferSize: 2)
        replay.onNext(1)
        replay.onNext(2)
        replay.subscribe {
            print("ReplaySubject : \($0)")
        }.disposed(by: disposeBag)
        replay.onNext(3)
        replay.onNext(4)
        
        let behavior = BehaviorSubject(value: 0)
        behavior.onNext(1)
        behavior.onNext(2)
        behavior.subscribe {
            print("BehaviorSubject : \($0)")
        }.disposed(by: disposeBag)
        behavior.onNext(3)
        behavior.onNext(4)
        
        let variable = Variable<Int>(0)
        variable.value = 1
        variable.value = 2
        variable.asObservable().subscribe {
            print("variable : \($0)")
        }.disposed(by: disposeBag)
        variable.value = 3
        variable.value = 4
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

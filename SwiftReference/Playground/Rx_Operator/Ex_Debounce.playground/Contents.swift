//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

public func delay(_ when: Double, _ block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(when * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
}


print("Debounce")
/*
 ------(1)-(2)-(3)--------(4)------
 debounce(time)
 -------------------(3)--------(4)-
 */

do {
    let bounce = PublishSubject<Int>()
    
    bounce
        .asObservable()
        .debounce(.milliseconds(3000), scheduler: MainScheduler.instance)
        .subscribe(onNext: { value in
            print(Date())
            print(value)
        })
        .disposed(by: disposeBag)
    print(Date())
    bounce.onNext(1)
    bounce.onNext(2)
    bounce.onNext(3)
    delay(2) {
        print(Date())
        bounce.onNext(4)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true

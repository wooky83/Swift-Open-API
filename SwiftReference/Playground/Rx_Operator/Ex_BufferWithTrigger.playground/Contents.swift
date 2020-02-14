//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxSwiftExt
import PlaygroundSupport

let disposeBag = DisposeBag()

print("bufferWithTrigger from RxSwiftExt")
/*
 ------(1)-(2)-(3)------(4)-(5)-----
 Buffer
 --------(0)-------(0)----------(0)-
 */

do {
    let trigger = PublishSubject<Void>()
    let ps = PublishSubject<Int>()
    
    ps
        .bufferWithTrigger(trigger)
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: disposeBag)
    
    ps.onNext(1)
    ps.onNext(2)
    ps.onNext(3)
    trigger.onNext(())
    ps.onNext(4)
    ps.onNext(5)
    trigger.onNext(())
}

PlaygroundPage.current.needsIndefiniteExecution = true

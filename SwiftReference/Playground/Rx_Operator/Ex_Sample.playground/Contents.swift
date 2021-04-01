//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxOptional
import PlaygroundSupport

let disposeBag = DisposeBag()

print("Custom Sample")
/*
 ------(1)-(2)-------(3)--------(4)------   //Value
 --------------(*)-----------------------   //Trigger
 Custom Sample(time)
 --------------(2)---(3)--------(4)------
 */

do {
    let tip = BehaviorSubject<String?>(value: nil)
    let trigger = PublishSubject<Void>()

    Observable.merge(tip.sample(trigger).take(1), tip.skip(until: trigger))
        .filterNil()
        .subscribe(onNext: {
            print("Good Luck : \($0)")
        })
        .disposed(by: disposeBag)
    
    tip.onNext("1")
    tip.onNext("2")
    trigger.onNext(())
    tip.onNext("3")
    tip.onNext("4")
    tip.onNext("5")
    trigger.onNext(())
}

print("------------------------------------------------------------")
print("Sample")
/*
 ------(1)-(2)-------(3)--------(4)------------   //Value
 --------------(*)--------(*)---------(*)------   //Trigger
 Custom Sample(time)
 --------------(2)--------(3)---------(4)-
 */

do {
    let sample = BehaviorSubject<String>(value: "1")
    let trigger = PublishSubject<Void>()
    
    sample.asObserver().sample(trigger)
        .subscribe(onNext: {
            print("Good Luck : \($0)")
        })
        .disposed(by: disposeBag)
    
    sample.onNext("1")
    sample.onNext("2")
    trigger.onNext(())
    sample.onNext("3")
    trigger.onNext(())
    sample.onNext("4")
    trigger.onNext(())
}

PlaygroundPage.current.needsIndefiniteExecution = true

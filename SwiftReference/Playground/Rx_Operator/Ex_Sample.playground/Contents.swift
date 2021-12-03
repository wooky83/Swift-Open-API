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

    let csDis: Disposable = Observable.merge(tip.sample(trigger).take(1), tip.skip(until: trigger))
        .filterNil()
        .subscribe(onNext: {
            print("Good Luck 1: \($0)")
        })
    
    tip.onNext("1")
    tip.onNext("2")
    trigger.onNext(())
    tip.onNext("3")
    tip.onNext("4")
    tip.onNext("5")
    trigger.onNext(())
    
    csDis.dispose()
    print("😀😀😀-----------------------------------")
    let dis = Observable.merge(tip.sample(trigger).take(1), tip.skip(until: trigger))
        .filterNil()
        .subscribe(onNext: {
            print("Good Luck 2: \($0)")
        })
    
    tip.onNext("1")
    tip.onNext("2")
    trigger.onNext(())
    tip.onNext("3")
    tip.onNext("4")
    tip.onNext("5")
    trigger.onNext(())
    
    dis.dispose()
    tip
        .skipUntilSample(trigger)
        .subscribe(onNext: {
            print("Debug Here is \($0)")
        })
    
    tip.onNext("1")
    tip.onNext("2")
    tip.onNext("3")
    trigger.onNext(())
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

extension ObservableType {

    /*
     ------(1)-(2)-------(3)--------(4)------   //Value
     --------------(*)-----------------------   //Trigger
     Custom Sample(time)
     --------------(2)---(3)--------(4)------
     */

    public func skipUntilSample<Source: ObservableType>(_ sampler: Source)
        -> Observable<Element> {
            return Observable.merge(self.asObservable().sample(sampler.asObservable()).take(1), self.asObservable().skip(until: sampler.asObservable()))
    }
}

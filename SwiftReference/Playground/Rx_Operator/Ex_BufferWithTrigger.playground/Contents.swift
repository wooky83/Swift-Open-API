//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import PlaygroundSupport

let disposeBag = DisposeBag()

print("bufferWithTrigger from RxSwiftExt")
/*
 ------(1)-(2)-(3)------(4)-(5)-----
 --------------(*)-------------------   //Trigger
 Buffer tirgger
 -------------([1,2])---------------
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

/*
------(1)-(2)-(3)------(4)-(5)-----(time span)
Buffer
-------------([1,2])---------------
*/
print("buffer")

do {
    let ps = PublishRelay<Int>()
    
    ps
        .buffer(timeSpan: .milliseconds(100), count: 10, scheduler: MainScheduler.instance)
        .take(1)
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: disposeBag)
    
    ps.accept(1)
    ps.accept(2)
    ps.accept(3)
    ps.accept(4)
    ps.accept(5)
}

PlaygroundPage.current.needsIndefiniteExecution = true

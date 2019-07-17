//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)

print("ObserveOn_SubscribeOn")
/*
 */

do {
    
    
    Observable.from([1,2,3,4,5])
        .map { n -> Int in
            print("This is performed on background scheduler, \(Thread.current)")
            return n * 2
        }
        .subscribeOn(backgroundScheduler)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {
            print("Result : \($0), \(Thread.current)")
        })
}


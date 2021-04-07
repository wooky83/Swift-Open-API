//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


print("Behavior Subject")

/*
    BehaviorSubject는 구독후에 가장 최근 이벤트를 전달
    초기값 필요함.......
 */

do {
    let behaviorSubject = BehaviorSubject(value: "goodluck")

    behaviorSubject.subscribe(onNext: {
        print("pub1 : \($0)")
    })
    
    behaviorSubject.onNext("Good")
    behaviorSubject.onNext("game")
    
    behaviorSubject.subscribe(onNext: {
        print("pub2 : \($0)")
    })
    behaviorSubject.onNext("Both subscription get this message.")
    
}



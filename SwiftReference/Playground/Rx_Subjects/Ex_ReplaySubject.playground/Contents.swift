//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


print("Replay Subject")

/*
    ReplaySubject는 구독 전에 발생한 이벤트를 Buffer에 넣는다.
    구독할때 Buffer에 있는 이벤트를 전달함
    버퍼크기가 0이라면 publishSubject와 같다...
    초기값 불필요
 */

do {
    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    
    subject.subscribe(onNext: {
        print("pub1 : \($0)")
    })
    
    subject.onNext(1)
    subject.onNext(2)
    
    subject.subscribe(onNext: {
        print("pub2 : \($0)")
    })
    subject.onNext(3)
    
}



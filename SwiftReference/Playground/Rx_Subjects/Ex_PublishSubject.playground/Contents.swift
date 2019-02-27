//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

print("PublishSubject")

/*
    PublishSubject는 구독한 뒤에 Observable이 보낸 이벤트를 전달
    초기값 필요 없음.......
 */

do {
    let publishSubject = PublishSubject<String>()
    
    publishSubject.onNext("hi")
    publishSubject.onNext("wooky")
    
    publishSubject.subscribe(onNext: {
        print("pub1 : \($0)")
    })
    
    publishSubject.onNext("Good")
    publishSubject.onNext("game")
    
    publishSubject.subscribe(onNext: {
        print("pub2 : \($0)")
    })
    publishSubject.onNext("Both subscription get this message.")
    
}



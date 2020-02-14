//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("PublishRelay Subject")

/*
    PublishRelay은 PublisSubject의 Wrapper
    그러나 complete나 error 이벤트 발생하지 않는다.
    그리고 PublisSubject는 다른 Subject와 달리 RxCocoa를 Improt 해줘야함...
    초기값 필요없다잉
 */

do {
    let bvSubject = PublishRelay<Int>()
    let subject = bvSubject.asObservable()
    
    bvSubject.accept(0)
    
    subject.subscribe(onNext: {
        print("Observer1 is : \($0)")
    })

    bvSubject.accept(1)
    bvSubject.accept(2)
    
    print("\n")
    
    subject.subscribe(onNext: {
        print("Observer2 is : \($0)")
    })
    
    bvSubject.accept(3)
}



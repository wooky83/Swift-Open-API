//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("BehaviorRelay Subject")

/*
    BehaviorRelay은 BehaviorSubject의 Wrapper
    그러나 complete나 error 이벤트 발생하지 않는다.
    Variable와 달리 BehaviorRelay는 value에 바로 값을
    Set할수 없다... 불편하다잉
    그리고 BehaviorSubject는 다른 Subject와 달리 RxCocoa를 Improt 해줘야함...
    초기값 필요하다잉
 */

do {
    let bvSubject = BehaviorRelay<[Int]>(value: [])
    let subject = bvSubject.asObservable()
    
    subject.subscribe(onNext: {
        print("pub1 : \($0)")
    })

    bvSubject.accept([1, 2, 3, 4, 5])
/*
     아래와 같이 value값에 바로 Set할수 없다..
     Cannot use mutating member on immutable value: 'value' is a get-only property
 */
//    bvSubject.value.append(3)
    
    var value = bvSubject.value
    value.append(6)
    bvSubject.accept(value)
    
    print("\n")
    
    subject.subscribe(onNext: {
        print("pub2 : \($0)")
    })
    
    bvSubject.accept([3, 6, 9])
}

/*
 Reference를 이용하면 value에 Set을 할수 있지만
 Subscribe를 하지는 못한다....
 */
do {
    let bvSubject = BehaviorRelay<NSMutableArray>(value: [])
    let subject = bvSubject.asObservable()
    
    subject.subscribe(onNext: {
        print("nsobject1 : \($0)")
    })
    
    bvSubject.accept([1, 2, 3, 4, 5])
    bvSubject.value.add(0)
    print("\n")
    
    subject.subscribe(onNext: {
        print("nsobject2 : \($0)")
    })
    
    bvSubject.accept([3, 6, 9])
}



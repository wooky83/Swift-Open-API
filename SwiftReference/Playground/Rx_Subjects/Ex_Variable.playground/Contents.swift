//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


print("Variable Subject")

/*
    Variable은 BehaviorSubject의 Wrapper
    그러나 complete나 error 이벤트 발생하지 않는다.
    Variable의 value값에 바로 접근가능해서 편리함
    근데 Deprecated가 되었음 ㅠ.ㅠ
    초기값 필요하다잉
    rxswift 6.x 부터 deprecated
 */

//do {
//    let variableSubject = Variable<[Int]>([])
//    let subject = variableSubject.asObservable()
//    
//    subject.subscribe(onNext: {
//        print("pub1 : \($0)")
//    })
//    
//    variableSubject.value = [1, 2, 3, 4, 5]
//    variableSubject.value = [5, 6, 7]
//    variableSubject.value.append(8)
//    variableSubject.value.remove(at: 2)
//    
//    print("\n")
//    
//    subject.subscribe(onNext: {
//        print("pub2 : \($0)")
//    })
//    
//    variableSubject.value = [3, 6, 9]
//    
//}



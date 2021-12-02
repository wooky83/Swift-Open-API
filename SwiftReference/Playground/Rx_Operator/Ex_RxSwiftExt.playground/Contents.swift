//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxOptional
import RxSwiftExt
import PlaygroundSupport

let disposeBag = DisposeBag()


print("Pairwise")
/*
 ----(0)----(1)----(2)----(3)-----------------------
 Pairwise
 -----------(0,1)--(1,2)--(2,3)-------------------
 */

do {
    let subject = BehaviorSubject<Int>(value: 0)
    
    subject.asObserver()
        .pairwise()
        .subscribe(onNext: { pre, next in
            print("pre : \(pre), current: \(next)")
        })
        .disposed(by: disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
}

print("------------------------------------------------------------")
print("mapAt")
//keyPath를 이용해서 struct, class의 Value를 Subscribe한다

/*
 ------(0,*)------(1,$)------(2,?)--------------
 mapAt
 ------(*)--------($)--------(?)----------------
 */

do {
    struct Sport {
        let name: String
        let rate: Int
        let tag: String
    }
    
    let sj = PublishSubject<Sport>()
    
    sj.asObserver()
        .mapAt(\.tag)
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: disposeBag)
    
    sj.onNext(Sport(name: "baseBall", rate: 0, tag: "*"))
    sj.onNext(Sport(name: "Soccer", rate: 1, tag: "$"))
    sj.onNext(Sport(name: "Golf", rate: 2, tag: "?"))
}

/*
 ------(1)------(2)------(3)------(4)------
 filterMap ($0 % 2 == 0)
 ------(1)---------------(3)---------------
 */

do {
    // keep only even numbers and double them
    Observable.of(1,2,3,4)
        .filterMap { number in
            (number % 2 == 0) ? .ignore : .map(number * 2)
        }
        .subscribe(onNext: {
            print($0)
        })
}

PlaygroundPage.current.needsIndefiniteExecution = true

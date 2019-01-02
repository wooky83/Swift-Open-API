//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxOptional
import PlaygroundSupport

let disposeBag = DisposeBag()

print("CombineLatest")
/*
 ------(1)-----(2)------------------------------   //first
 ------------------(5)----(6)-------------------   //second
 CombineLatest
 ------------------(2,5)--(2,6)-----------------
 */

do {
    let firstSubject = PublishSubject<String>()
    let secondSubject = PublishSubject<String>()

    Observable.combineLatest(firstSubject, secondSubject)
        .subscribe(onNext: { fValue, sValue in
            print("value : \(fValue), \(sValue)")
        })
        .disposed(by: disposeBag)
    
    firstSubject.onNext("1")
    firstSubject.onNext("2")
    
    secondSubject.onNext("5")
    secondSubject.onNext("6")
}

print("------------------------------------------------------------")
print("CombineLatest take(1)")
//Async하게 모든 Task가 끝날때 Subscribe
/*
 ------(1)-----(2)------------------------------   //first
 ------------------(5)----(6)-------------------   //second
 CombineLatest take(1)
 ------------------(2,5)-|
 */

do {
    let firstSubject = PublishSubject<String>()
    let secondSubject = PublishSubject<String>()
    
    Observable.combineLatest(firstSubject, secondSubject)
        .take(1)
        .subscribe(onNext: { fValue, sValue in
            print("value : \(fValue), \(sValue)")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        })
        .disposed(by: disposeBag)
    
    firstSubject.onNext("1")
    firstSubject.onNext("2")
    
    secondSubject.onNext("5")
    secondSubject.onNext("6")
    secondSubject.onNext("7")
}

PlaygroundPage.current.needsIndefiniteExecution = true

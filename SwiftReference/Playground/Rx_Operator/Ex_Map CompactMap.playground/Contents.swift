//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("map compactMap")
/*
 */

do {
    
    let subject = PublishSubject<Int?>()
    
    subject
        .map { value in
            String("string i \(value ?? 0)")
        }
        .subscribe(onNext: {
            print($0)
        })
    
    subject.onNext(10)
    subject.onNext(nil)
}

print("---------------------------------------------------------")

do {
    
    let subject = PublishSubject<Int?>()
    
    subject
        .compactMap {
            if let v = $0 {
                return String("string i \(v)")
            } else {
                return nil
            }
        }
        .subscribe(onNext: {
            print($0)
        })
    
    subject.onNext(7)
    subject.onNext(nil)
}


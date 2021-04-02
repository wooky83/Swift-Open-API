//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("FlatMap")
/*
 */

do {
    
    struct Student {
        var score: BehaviorRelay<Int>
    }
    
    let sung = Student(score: BehaviorRelay(value: 99))
    let wook = Student(score: BehaviorRelay(value: 80))
    
    let student = PublishRelay<Student>()
    
    student
        .flatMap {
            $0.score
        }
        .subscribe(onNext: {
            print($0)
        })
    
    student.accept(sung)
    sung.score.accept(70)
    student.accept(wook)
    wook.score.accept(60)
}

print("----------------------------")

do {
    
    let behavior = BehaviorRelay(value: 1)
    let fHavior = BehaviorRelay(value: 2)
    
    behavior
        .flatMap { _ in
            fHavior
        }
        .subscribe(onNext: {
            print($0)
        })
    
    behavior.accept(20)
    behavior.accept(3)
    fHavior.accept(7)
 
}


//func flatMap<Source>(_ selector: @escaping (Student) throws -> Source) -> Observable<Source.Element> where Source : ObservableConvertibleType
//func map<Result>(_ transform: @escaping (Int) throws -> Result) -> Observable<Result>

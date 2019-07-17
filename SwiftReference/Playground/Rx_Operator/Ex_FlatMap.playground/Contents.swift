//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("FlatMap")
/*
 */

do {
    
    struct Student {
        var score: Variable<Int>
    }
    
    let sung = Student(score: Variable(99))
    let wook = Student(score: Variable(80))
    
    let student = PublishSubject<Student>()
    
    student
        .flatMap {
            $0.score.asObservable()
        }
        .subscribe(onNext: {
            print($0)
        })
    
    student.onNext(sung)
    sung.score.value = 90
    student.onNext(wook)
    wook.score.value = 9
}


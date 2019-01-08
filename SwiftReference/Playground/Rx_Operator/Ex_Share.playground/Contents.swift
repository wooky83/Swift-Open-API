//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxOptional
import RxSwiftExt
import PlaygroundSupport

let disposeBag = DisposeBag()


print("Normal")
/*
 ----(0)----(1)----(2)----(3)-----------------------
 Pairwise
 -----------(0,1)--(1,2)--(2,3)-------------------
 */

do {
    
    let xs: Observable<Double> = Observable.create { observer in
        print("Performing work ...")
        observer.onNext(Date().timeIntervalSince1970)
        return Disposables.create()
    }
    
    xs.subscribe(onNext: { print("first: next \($0)") }).dispose()
    xs.subscribe(onNext: { print("second: next \($0)") })
    

}

print("")
print("Share")

do {
    
    let xs: Observable<Double> = Observable.create { observer in
        print("Performing work ...")
        observer.onNext(Date().timeIntervalSince1970)
        return Disposables.create()
    }
    .share(replay: 1, scope: .forever)
    
    xs.subscribe(onNext: { print("first: next \($0)") }).dispose()
    xs.subscribe(onNext: { print("second: next \($0)") })
    
    
}
PlaygroundPage.current.needsIndefiniteExecution = true

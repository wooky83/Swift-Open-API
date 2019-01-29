//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxSwiftExt
import PlaygroundSupport

let disposeBag = DisposeBag()

print("Async")

func timeout(_ second: Int, completed: @escaping (Int) -> Void) {

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(second)) {
        completed(Int.random(in: 0..<100))
    }
}


do {
    let asyncObj = Observable.fromAsync(timeout)
    asyncObj(3)
        .subscribe(onNext: { result in
            print("1 Argument : \(result)")
        })
        .disposed(by: disposeBag)
}


PlaygroundPage.current.needsIndefiniteExecution = true

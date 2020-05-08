//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

print("distinctUntilChanged from RxSwift")
/*
 ------(1)-(2)-(2)------(4)-(5)-----
 distinctUntilChanged
 ------(1)-(2)----------(4)-(5)-----
 */

do {
    let relay = PublishRelay<Int>()
    relay
        .distinctUntilChanged()    //equal .distinctUntilChanged { $0 == $1 }
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: disposeBag)
    
    relay.accept(1)
    relay.accept(2)
    relay.accept(2)
    relay.accept(4)
    relay.accept(5)
    
    let csRelay = PublishRelay<String>()
      csRelay
          .distinctUntilChanged { $0 == $1 }
          .subscribe(onNext: { value in
              print(value)
          })
          .disposed(by: disposeBag)
      
      csRelay.accept("a")
      csRelay.accept("a")
      csRelay.accept("c")
      csRelay.accept("a")
      csRelay.accept("e")
}

PlaygroundPage.current.needsIndefiniteExecution = true

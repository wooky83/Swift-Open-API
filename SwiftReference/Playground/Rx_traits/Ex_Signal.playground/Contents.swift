import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("Signal")

/*
    UI레이어에 reactive 코드를 작성하는 직관적인 방법을 제공하거나 애플리케이션에서 데이터 스트림을 모델링하는 모든 경우
        1. 오류가 없습니다.(오류를 방출하지 않는다는 의미)
        2. observe는 Main scheulder에서 발생합니다.
        3. 초기값 및 최신값을 주지 않는다.
 
  ------(1)-(2)-(3)------(4)-(5)-----
            signal
              --(3)------(4)-(5)-----
 
 */

do {
    
    let p = PublishSubject<Int>()
    p.onNext(3)
    p.asSignal(onErrorJustReturn: 0)
        .emit(onNext: {
            print($0)
        })
    
    p.onNext(2)
    
    print("--------------------")
    
    let pr = BehaviorRelay<Int>(value: 5)
    
    pr.asSignal(onErrorJustReturn: 0)
        .emit(onNext: {
            print($0)
        })
    
    pr.accept(7)
}

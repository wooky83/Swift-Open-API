import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("Infallible traits")

/*
    Infallible는 Observable과 한가지가 다른 새로운 타입입니다. Infallible는 실패하지 않습니다. 다시 말하면 .error 이벤트를 방출(emit)하지 않습니다.
 */


do {
    
    let inf = Infallible<String>
        .create { s in 
            if Bool.random() {
                s(.completed)
            } else {
                s(.next("wooky"))
            }
            return Disposables.create()
        }
    
    
    inf
        .subscribe(onNext: { s in
            print(s)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("Disposed")
        })

}

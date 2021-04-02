import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("Completable traits")

/*
    Completable은 변화무쌍한 Observable 입니다. complete 하거나, error 를 방출하고, 아무 요소도 방출하지 않는것을 보장합니다.
 */

enum MyError: Error {
    case Unknown
}

do {
    
    let comp = Completable
        .create { s in
            if Bool.random() {
                s(.completed)
            } else {
                s(.error(MyError.Unknown))
            }
            return Disposables.create()
        }
    
    comp
        .subscribe(onCompleted: {
            print("completed")
        }, onError: {
            print($0)
        }, onDisposed: {
            print("Disposed!!")
        })

    
}

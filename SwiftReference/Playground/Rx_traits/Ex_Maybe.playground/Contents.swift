import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("Maybe traits")

/*
    Single과 Completable사이에 있는 Observable의 변형입니다. 단일 요소를 방출하거나 요소를 방출하지 않고 완료하거나 오류를 낼수 있습니다. ( Single, Completable 두가지 모두 가지고 있음)
 */

enum MyError: Error {
    case Unknown
}

do {
    
    let may = Maybe<String>
        .create { s in
            switch Int.random(in: 1...3) {
            case 1:
                s(.success("Good"))
            case 2:
                s(.completed)
            case 3:
                s(.error(MyError.Unknown))
            default:
                s(.error(MyError.Unknown))
            }
            return Disposables.create()
        }
    
    may
        .subscribe(onSuccess: {
            print($0)
        }, onError: {
            print($0)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })

    
}

import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("Sing traits")

/*
    Single은 Observable의 변형으로 일련의 요소를 방출하는 대신 항상 단일 요소 또는 오류를 방출하도록 보장합니다.
    정확히 하나의 요소 또는 error를 방출합니다. 부수작용을 공유하지 않습니다.
 */

enum MyError: Error {
    case Unknown
}

do {
    
    let single = Single<String>
        .create { s in
            if Bool.random() {
                s(.success("success"))
            } else {
                s(.failure(MyError.Unknown))
            }
            return Disposables.create()
        }
    
    
    single
        .subscribe(onSuccess: { s in
            print(s)
        }, onFailure: {
            print($0)
        }, onDisposed: {
            print("Disposed")
        })

}

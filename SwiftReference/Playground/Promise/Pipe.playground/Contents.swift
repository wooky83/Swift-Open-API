//: Playground - noun: a place where people can play

import UIKit
import PromiseKit

enum CSError: Error {
    case unkwon
}

func promise1() -> Promise<Bool> {
    .value(true)
}

func promise2(_ empty: String) -> Promise<Int> {
    return Promise { seal in
        promise3(true).pipe(to: seal.resolve)
    }
}

func promise3(_ param: Bool) -> Promise<Int> {
    return Promise { seal in
        if (Int.random(in: 1..<10) % 2) == 0 {
            seal.fulfill(7)
        } else {
            seal.reject(CSError.unkwon)
        }
    }
}

firstly { () -> Promise<Bool> in
    print("firstly")
    return promise1()
}
.map { param in
    "😃 \(param)"
}
.get {
    print("get is \($0)")
}
.then {
    promise2($0)
}
.done { result in
    print("done : \(result)")
}
.ensure {
    print("ensure")
}
.catch { error in
    print("error is \(error)")
}
.finally {
    print("finally")
}

//: Playground - noun: a place where people can play

import UIKit
import PromiseKit

enum CSError: Error {
    case unkwon
}

func timeOut() -> Promise<Bool> {
    return Promise { seal in
        if (Int.random(in: 1..<10) % 2) == 0 {
            seal.fulfill(true)
        } else {
            seal.reject(CSError.unkwon)
        }
    }
}

firstly {
    timeOut()
}
.done { value in
    print(value)
}
.ensure {
    print("ensure")
}
.catch { error in
    print(error)
}
.finally {
    print("finally")
}



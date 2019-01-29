//: Playground - noun: a place where people can play

import UIKit
import PromiseKit

enum CSError: Error {
    case unkwon
}

func timeOut1(_ second: Int) -> Promise<Int> {
    return Promise { seal in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(second)) {
            return seal.fulfill(Int.random(in: 1..<10))
        }
    }
}


firstly {
    when(fulfilled: timeOut1(1), timeOut1(3), timeOut1(5))
}
.done { result1, result2, result3 in
    print("result : \(result1), \(result2), \(result3)")
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



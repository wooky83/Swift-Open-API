//: Playground - noun: a place where people can play

import UIKit
import PromiseKit

class Pending: NSObject {
    private let (promise, seal) = Promise<Int>.pending()
    
    func getPromise() -> Promise<Int> {
        after(seconds: 2).done {
            print("promsie After")
            self.seal.fulfill(83)
        }
        return promise
    }
    
    func getGuarantee() -> Guarantee<Int> {
        return Guarantee { sl in
            after(seconds: 3).done {
                sl(8)
            }
        }
    }
}

let test = Pending()

firstly {
    test.getPromise()
}
.done {
    print("done is \($0)")
}

let result1 = test.getGuarantee().value
print(result1 ?? "nil")

print(Thread.current)
DispatchQueue.global().async {
    print(Thread.current)
    let result2 = test.getGuarantee().wait()
    print(result2)
}


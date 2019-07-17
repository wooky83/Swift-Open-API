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
    
}

let test = Pending()

firstly {
    test.getPromise()
}
.done {
    print("done is \($0)")
}

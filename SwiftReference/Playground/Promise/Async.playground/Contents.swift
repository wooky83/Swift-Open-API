//: Playground - noun: a place where people can play

import UIKit
import PromiseKit
import PlaygroundSupport

enum CSError: Error {
    case unkwon
}

public func delay(_ when: Double, _ block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(when * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
}

func method() -> Promise<Bool> {
    print("method")
    return Promise { seal in
        delay(1) {
            
            method1()
                .pipe(to: {
                    seal.resolve($0)
                })
        }
    }
    
}

func method1() -> Promise<Bool> {
    print("method1")
    return Promise.value(true)
}


firstly {
    method()
}
.ensure {
    print("ensure1")
}
.done { value in
    print(value)
}
.ensure {
    print("ensure2")
}
.catch { error in
    print(error)
}
.finally {
    print("finally")
}



PlaygroundPage.current.needsIndefiniteExecution = true


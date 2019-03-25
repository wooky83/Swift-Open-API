//: Playground - noun: a place where people can play

import UIKit
import PromiseKit

enum CSError: Error {
    case unkwon
}

func af(_ second: Int) -> Guarantee<Int> {
    return Guarantee { gu in
        gu(5)
    }
}

firstly {
    af(3)
}
.get {
    print("get is \($0)")
}
.done {
    print("done is \($0)")
}


firstly {
    .value(1)
}
.get { foo in
    print(foo, "is 1")
}

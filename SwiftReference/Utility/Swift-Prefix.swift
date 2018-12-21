//
//  Swift-Prefix.swift
//  SwiftReference
//
//  Created by baw0803 on 2017. 10. 19..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import Foundation

func curry<X, Y, Z>(_ f:@escaping (X,Y)->Z)->(X)->(Y)->Z {
    return { X in { Y in f(X,Y) } }
}

func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) } } }
}

func bind<A, B>(_ a: A?, f: (A) -> B?) -> B?
{
    if let x = a {
        return f(x)
    } else {
        return .none
    }
}

infix operator >>=: MultiplicationPrecedence
func >>=<A, B>(a: A?, f: (A) -> B?) -> B?
{
    return bind(a, f: f)
}

public func delay(_ when: Double, _ block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(when * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
}

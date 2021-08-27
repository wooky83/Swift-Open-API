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

//String Value operator
//nil or empty 일 경우 false

postfix operator ⁇
postfix func ⁇<T: StringProtocol>(lhs: T?) -> Bool {
    guard let str = lhs else { return false }
    return !str.trimmingCharacters(in: .whitespaces).isEmpty
}

postfix func ⁇<T: SignedInteger>(lhs: T?) -> Bool {
    guard let number = lhs else { return false }
    return number > 0
}

postfix func ⁇<T: BinaryFloatingPoint>(lhs: T?) -> Bool {
    guard let number = lhs else { return false }
    return number > 0
}

postfix func ⁇<T: Collection>(lhs: T?) -> Bool {
    guard let array = lhs else { return false }
    return !array.isEmpty
}

postfix operator ‽
postfix func ‽(lhs: String?) -> String {
    lhs ?? ""
}

postfix func ‽(lhs: Bool?) -> Bool {
    lhs ?? false
}

postfix func ‽<T: SignedInteger>(lhs: T?) -> T {
    lhs ?? 0
}

postfix func ‽<T: Collection>(lhs: T?) -> T {
    lhs ?? [] as! T
}

//대소문자 구분없이 비교
infix operator ≡
func ≡(lhs: String?, rhs: String?) -> Bool {
    guard let left = lhs, let right = rhs else { return false }
    return left.compare(right, options: .caseInsensitive) == .orderedSame
}

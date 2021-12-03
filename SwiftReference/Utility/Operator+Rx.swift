//
//  Operator+Rx.swift
//  SwiftReference
//
//  Created by sungwook on 2021/12/03.
//  Copyright © 2021 wooky83. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {

    /*
     ------(1)-(2)-------(3)--------(4)------   //Value
     --------------(*)-----------------------   //Trigger
     Custom Sample(time)
     --------------(2)---(3)--------(4)------
     */

    public func skipUntilSample<Source: ObservableType>(_ sampler: Source)
        -> Observable<Element> {
            return Observable.merge(self.asObservable().sample(sampler.asObservable()).take(1), self.asObservable().skip(until: sampler.asObservable()))
    }
}

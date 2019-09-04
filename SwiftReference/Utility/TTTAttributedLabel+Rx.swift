//
//  TTTAttributedLabel+Rx.swift
//  SwiftReference
//
//  Created by wooky83 on 04/09/2019.
//  Copyright © 2019 wooky83. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: TTTAttributedLabel {
    var delegate: DelegateProxy<TTTAttributedLabel, TTTAttributedLabelDelegate> {
        return RxTTTAttributedLabelDelegateProxy.proxy(for: self.base)
    }
    
    var didSelectLink: Observable<URL?> {
        let selector = #selector(
            ((TTTAttributedLabelDelegate.attributedLabel(_:didSelectLinkWith:))!
                as (TTTAttributedLabelDelegate) -> (TTTAttributedLabel, URL) -> Void))
        
        return delegate.methodInvoked(selector)
            .map { $0[1] as? URL}
    }
}


class RxTTTAttributedLabelDelegateProxy: DelegateProxy<TTTAttributedLabel, TTTAttributedLabelDelegate>, DelegateProxyType, TTTAttributedLabelDelegate {
    
    public init(label: ParentObject) {
        super.init(parentObject: label, delegateProxy: RxTTTAttributedLabelDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register(make: RxTTTAttributedLabelDelegateProxy.init)
    }
    
    static func currentDelegate(for object: TTTAttributedLabel) -> TTTAttributedLabelDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: TTTAttributedLabelDelegate?, to object: TTTAttributedLabel) {
        object.delegate = delegate
    }
}

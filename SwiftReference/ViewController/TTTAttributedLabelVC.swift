//
//  TTTAttributedLabelVC.swift
//  SwiftReference
//
//  Created by wooky83 on 04/09/2019.
//  Copyright © 2019 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxSwiftExt
import RxCocoa

class TTTAttributedLabelVC: BaseVC {

    @IBOutlet weak var attributedLb: TTTAttributedLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let text = attributedLb.text as? NSString {
            attributedLb.addLink(to: URL(string: "http://www.naver.com"), with: text.range(of: "롯데"))
            attributedLb.addLink(to: URL(string: "http://www.daum.net"), with: text.range(of: "선수단"))
            attributedLb.addLink(to: URL(string: "http://www.google.com"), with: text.range(of: "코치"))
        }
        
        
        let custom = CustomClass()
        custom.rx
            .willStart
            .subscribe(onNext: {
                print("Here is \($0)")
            })
            .disposed(by: rx.disposeBag)
        custom.start()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@objc protocol CustomClassDelegate: AnyObject {
    @objc optional func willStart(str: String)
}

class CustomClass: NSObject {
    weak var csDelegate: CustomClassDelegate? = nil
    func start() {
        self.csDelegate?.willStart?(str: "Good Luck to you!!")
    }
}

class RxCustomDelegateProxy: DelegateProxy<CustomClass, CustomClassDelegate>, DelegateProxyType, CustomClassDelegate {
    static func registerKnownImplementations() {
        self.register { (TT) -> RxCustomDelegateProxy in
            RxCustomDelegateProxy.init(parentObject: TT, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: CustomClass) -> CustomClassDelegate? {
        return object.csDelegate
    }
    
    static func setCurrentDelegate(_ delegate: CustomClassDelegate?, to object: CustomClass) {
        object.csDelegate = delegate
    }
}

extension Reactive where Base: CustomClass{
    var delegate : DelegateProxy<CustomClass, CustomClassDelegate>{
        return RxCustomDelegateProxy.proxy(for:self.base)
    }
    
    var willStart: Observable<String> {
        return delegate.methodInvoked(#selector(CustomClassDelegate.willStart(str:)))
            .compactMap {
                return $0[0] as? String
            }
    }
}

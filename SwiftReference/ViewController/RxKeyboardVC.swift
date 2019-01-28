//
//  RxKeyboardVC.swift
//  SwiftReference
//
//  Created by wooky83 on 28/01/2019.
//  Copyright © 2019 wooky83. All rights reserved.
//

import Foundation
import RxSwift
import RxKeyboard

class RxKeyboardVC: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
        
        for i in 1..<13 {
            let label = UILabel()
            label.frame = CGRect.init(x: 20, y: i*100, width: 100, height: 50)
            label.backgroundColor = .green
            label.text = String(Int.random(in: 0..<1000000))
            label.textAlignment = .center
            self.scrollView.addSubview(label)
            self.scrollView.contentSize.height = label.frame.origin.y + 100
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setupObservable() {
        RxKeyboard.instance
            .frame
            .drive(onNext: { frame in
                print("frame : \(frame)")
            })
            .disposed(by: rx.disposeBag)
        
        RxKeyboard.instance
            .visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let `self` = self else {return}
                print("keyboardVisibleHeight : \(keyboardVisibleHeight)")
                UIView.animate(withDuration: 0) {
                    self.scrollView.contentInset.bottom = keyboardVisibleHeight
                    self.scrollView.scrollIndicatorInsets.bottom = max(keyboardVisibleHeight - self.view.safeAreaInsets.bottom, 0)
                }
            })
            .disposed(by: rx.disposeBag)
        
        RxKeyboard.instance
            .willShowVisibleHeight
            .drive(onNext: { [weak self] visibleHeight in
                guard let `self` = self else {return}
                print("willShowVisibleHeight : \(visibleHeight)")
                self.scrollView.contentOffset.y += visibleHeight
            })
            .disposed(by: rx.disposeBag)
        
        RxKeyboard.instance
            .isHidden
            .drive(onNext: {
                print("isHidden : \($0)")
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    deinit {
        print("deinit")
    }
    
}

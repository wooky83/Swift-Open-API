//
//  RxCoCoaVC.swift
//  SwiftReference
//
//  Created by baw0803 on 2017. 10. 23..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BtnTxtFieldVC: UIViewController {
    
    @IBOutlet weak var idTextF: UITextField!
    @IBOutlet weak var passwordTextF: UITextField!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObservable()
    }
    
    private func setUpObservable() {
        
        let idObs = idTextF.rx.text.asObservable().map{!(($0?.isEmpty)!)}
        let pwObs = passwordTextF.rx.text.asObservable().map{!(($0?.isEmpty)!)}
        
        Observable.combineLatest(idObs, pwObs) {($0, $1)}.subscribe {
            switch $0 {
            case .next((true, true)):
                self.resultLabel.text = "good!"
            case .next((true, _)):
                self.resultLabel.text = "password plz!"
            case .next((_, true)):
                self.resultLabel.text = "id plz!"
            case .next((_, _)):
                self.resultLabel.text = "id and password plz!"
            default:()
            }
        }.disposed(by: rx.disposeBag)
        
        
        joinBtn.rx
            .tap
            .throttle(RxTimeInterval.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
            .subscribe { _ in
                self.showAlert()
            }
            .disposed(by: rx.disposeBag)
        
        self.rx.observe(CGRect.self, "frame")
            .subscribe(onNext: {
                print("frame is \(String(describing: $0))")
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Rxswift Test", message: "btn Clicked!", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

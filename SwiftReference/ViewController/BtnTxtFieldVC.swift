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
        
        idTextF.rx
            .controlEvent([.editingDidBegin, .editingDidEnd])
            .withUnretained(self)
            .map { ($0.0, $0.0.idTextF.isEditing) }
            .subscribe(onNext: { owner, isEditing in
                print("controlEvent \(isEditing)")
            })
            .disposed(by: rx.disposeBag)
        
        idTextF.rx
            .text
            .distinctUntilChanged()
            .map { $0⁇ }
            .subscribe(onNext: {
                print("rx text is \($0)")
            })
            .disposed(by: rx.disposeBag)
        
        idTextF.rx
            .observe(\.text)
            .withUnretained(self)
            .subscribe(onNext: { owner, field in
                print("rx text Observe is \(String(describing: field))")
            })
            .disposed(by: rx.disposeBag)
        
        let idObs = idTextF.rx.text.asObservable().map{!(($0?.isEmpty)!)}
        let pwObs = passwordTextF.rx.text.asObservable().map{!(($0?.isEmpty)!)}
        
        Observable.combineLatest(idObs, pwObs) {($0, $1)}
            .subscribe {
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
            }
            .disposed(by: rx.disposeBag)
        
        
        joinBtn.rx
            .tap
            .throttle(.milliseconds(300), latest: false, scheduler: MainScheduler.instance)
            .subscribe { _ in
                self.showAlert()
            }
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

class CSTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let defaultClearButton = UIButton.appearance(whenContainedInInstancesOf: [UITextField.self])
        defaultClearButton.setImage(UIImage(named: "sc_btn_delete"), for: .normal)
    }

}

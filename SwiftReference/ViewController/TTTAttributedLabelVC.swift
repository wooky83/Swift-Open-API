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

class TTTAttributedLabelVC: UIViewController {

    @IBOutlet weak var attributedLb: TTTAttributedLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let text = attributedLb.text as? NSString {
            attributedLb.addLink(to: URL(string: "http://www.naver.com"), with: text.range(of: "롯데"))
            attributedLb.addLink(to: URL(string: "http://www.daum.net"), with: text.range(of: "선수단"))
            attributedLb.addLink(to: URL(string: "http://www.google.com"), with: text.range(of: "코치"))
        }
        
        attributedLb.rx
            .didSelectLink
            .unwrap()
            .subscribe(onNext: {
                UIApplication.shared.open($0, options: [:], completionHandler: nil)
            })
            .disposed(by: rx.disposeBag)
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

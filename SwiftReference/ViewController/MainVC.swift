//
//  MainVC.swift
//  SwiftReference
//
//  Created by wooky83 on 2017. 10. 18..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainVC: UIViewController {
    
    private var subjects: Variable<[(String, String)]> = Variable([
        ("UIButton, UITextField", String(describing: BtnTxtFieldVC.self)),
        ("UISearchBar", String(describing: SearchVC.self)),
        ("Subjects(Publish, Replay, Behavior, Variable)", String(describing: SubjectsVC.self))
    ])
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var mainTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func setupObservable() {
        mainTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else {return}
            self.mainTableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: self.subjects.value[indexPath.row].1, sender: nil)
           
        }).disposed(by: disposeBag)
        
        self.subjects.asObservable().bind(to: self.mainTableView.rx.items) { tableView, row, data in
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CSCell.self)")!
            cell.textLabel?.text = data.0
            return cell
        }.disposed(by: disposeBag)
    }
    
}

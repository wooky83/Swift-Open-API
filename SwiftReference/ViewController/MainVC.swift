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
import RxDataSources

class MainVC: UIViewController {
    
    public private(set) var test: String?
    private var subjects: BehaviorRelay<[(title: String, identity: String)]> = BehaviorRelay(value: [
        ("UIButton, UITextField", "\(BtnTxtFieldVC.self)"),
        ("UISearchBar", "\(SearchVC.self)"),
        ("UITableView+RxDataSource", "\(TableViewDataSourceVC.self)"),
        ("Simple+UICollectionView", "\(SimpleCollectionVC.self)"),
        ("RxKeyboard", "\(RxKeyboardVC.self)"),
        ("RxTTTAttributedLabel", "\(TTTAttributedLabelVC.self)")
    ])
    
    
    @IBOutlet weak var mainTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
    }
    
    private func setupObservable() {
        mainTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else {return}
            self.mainTableView.deselectRow(at: indexPath, animated: true)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.subjects.value[indexPath.row].identity)
            vc.title = self.subjects.value[indexPath.row].title
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        
        self.subjects.asObservable().bind(to: self.mainTableView.rx.items) { tableView, row, data in
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CSCell.self)")!
            cell.textLabel?.text = data.title
            return cell
        }.disposed(by: rx.disposeBag)
    }
    
}

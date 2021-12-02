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

class MainVC: BaseVC {
    
    public private(set) var test: String?
    private var subjects: BehaviorRelay<[(title: String, identity: String, csType: BaseVC.Type)]> = BehaviorRelay(value: [
        ("UIButton, UITextField", "\(BtnTxtFieldVC.self)", BtnTxtFieldVC.self),
        ("UISearchBar", "\(SearchVC.self)", SearchVC.self),
        ("UITableView+RxDataSource", "\(TableViewDataSourceVC.self)", TableViewDataSourceVC.self),
        ("Simple+UICollectionView", "\(SimpleCollectionVC.self)", SimpleCollectionVC.self),
        ("RxKeyboard", "\(RxKeyboardVC.self)", RxKeyboardVC.self),
        ("RxTTTAttributedLabel", "\(TTTAttributedLabelVC.self)", TTTAttributedLabelVC.self),
        ("RxCollectionDataSource", "\(CollectionDataSourceVC.self)", CollectionDataSourceVC.self)
    ])
    
    
    @IBOutlet weak var mainTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
    }
    
    private func setupObservable() {
        mainTableView
            .rx
            .itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                owner.mainTableView.deselectRow(at: indexPath, animated: true)
                let story = UIStoryboard(name: "Main", bundle: nil)
                let identity = owner.subjects.value[indexPath.row].identity
                if let views = story.value(forKey: "identifierToNibNameMap") as? [String: Any], let _ = views[identity] {
                    let vc = story.instantiateViewController(withIdentifier: owner.subjects.value[indexPath.row].identity)
                    vc.title = owner.subjects.value[indexPath.row].title
                    owner.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let csType = owner.subjects.value[indexPath.row].csType
                    let vc = csType.init(nibName: "\(csType.self)", bundle: nil)
                    owner.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: rx.disposeBag)
        
        self.subjects
            .asDriver()
            .drive(self.mainTableView.rx.items) { tableView, row, data in
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(CSCell.self)")!
                cell.textLabel?.text = data.title
                return cell
            }.disposed(by: rx.disposeBag)
    }
    
}

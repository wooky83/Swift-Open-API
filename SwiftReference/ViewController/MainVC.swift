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

    let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
    private let sections = [
        SectionOfCustomData(header: "RxCocoa", items:
            [CustomData(title: "UIButton, UITextField", identity: "\(BtnTxtFieldVC.self)", useNib: true),
             CustomData(title: "UISearchBar", identity: "\(SearchVC.self)", useNib: true)]
        ),
        SectionOfCustomData(header: "Subjects", items:
            [CustomData(title: "Subjects(Publish, Replay, Behavior, Variable)", identity: "\(SubjectsVC.self)", useNib: true)]
        )
    ]
    
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
            
            let data = self.sections[indexPath.section].items[indexPath.row]

            if data.useNib {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: data.identity)
                self.navigationController?.pushViewController(vc, animated: true)
            } else if let dynamicClass = NSClassFromString(self.bundleName+"."+data.identity) as? UIViewController.Type {
                let vc = dynamicClass.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
           
        }).disposed(by: rx.disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CSCell.self)", for: indexPath)
            cell.textLabel?.text = item.title
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        Observable.just(sections)
            .bind(to: mainTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
    
}

struct CustomData {
    let title: String
    let identity: String
    let useNib: Bool
}

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}

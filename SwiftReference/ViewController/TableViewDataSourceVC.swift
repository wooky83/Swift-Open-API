//
//  TableViewDataSourceVC.swift
//  SwiftReference
//
//  Created by 1002659 on 20/12/2018.
//  Copyright © 2018 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class TableViewDataSourceVC: UIViewController {
    
    private let sections = [
        SectionOfCustomData(header: "Header_1", items:
            [CustomData(title: "T1"),
             CustomData(title: "T2")]
        ),
        SectionOfCustomData(header: "Header_2", items:
            [CustomData(title: "S1")]
        ),
        SectionOfCustomData(header: "Header_3", items:
            [CustomData(title: "S2")]
        )
    ]
    
    @IBOutlet weak var mainTableView: UITableView!
    
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

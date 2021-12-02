//
//  CollectionDataSourceVC.swift
//  SwiftReference
//
//  Created by sungwook on 2021/12/02.
//  Copyright © 2021 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CollectionDataSourceVC: BaseVC {
    
    private let itemsSjb = BehaviorRelay<[CollectionData]>(value: [CollectionData(title: 0)])
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "\(CollectionCell.self)")
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
        mainCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            
        }).disposed(by: rx.disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCollectionData>(configureCell: { dataSource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionCell.self)", for: indexPath) as? CollectionCell else {
                preconditionFailure("No Override FeedCollectionViewCell")
            }
            cell.configureCell(item.title)
            return cell
        })
        
        itemsSjb
            .asDriver()
            .map { [SectionOfCollectionData(items: $0)] }
            .drive(mainCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let randomNumber = Int.random(in: 1...100)
                var value = owner.itemsSjb.value
                value.append(CollectionData(title: randomNumber))
                owner.itemsSjb.accept(value)
            })
            .disposed(by: rx.disposeBag)
    }
    
}

class CollectionCell: UICollectionViewCell {
 
    private lazy var label: UILabel = {
        let view = UILabel(frame: self.bounds)
        view.textAlignment = .center
        self.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func configureCell(_ title: Int) {
        self.label.text = "\(title)"
    }
}

struct CollectionData {
    let title: Int
}

struct SectionOfCollectionData {
    var items: [Item]
}

extension SectionOfCollectionData: SectionModelType {
    typealias Item = CollectionData
    
    init(original: SectionOfCollectionData, items: [Item]) {
        self = original
        self.items = items
    }
}

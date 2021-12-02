//
//  SimpleCollectionView.swift
//  SwiftReference
//
//  Created by wooky83 on 07/01/2019.
//  Copyright © 2019 wooky83. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SimpleCollectionVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let model = BehaviorRelay<[String]>(value: [
        "good",
        "luck",
        "to",
        "you",
        "hi",
        "kwon",
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
    }

    private func setupObservable() {
        self.collectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        model.asObservable()
            .bind(to: self.collectionView.rx.items(cellIdentifier: "\(CustomCell.self)", cellType: CustomCell.self))({ row, md, cell in
                cell.setData(md)
            })
            .disposed(by: rx.disposeBag)
        
        self.collectionView.rx
            .itemSelected
            .subscribe(onNext: { index in
                print(index)
            })
            .disposed(by: rx.disposeBag)
    }
    
}

extension SimpleCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((UIScreen.main.bounds.size.width - 40) / 3)
        return CGSize(width: width, height: width)
    }
}

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var contentTitle: UILabel!
    
    func setData(_ txt: String?) {
        guard let txt = txt else {return}
        self.contentTitle.text = txt
    }
    
}



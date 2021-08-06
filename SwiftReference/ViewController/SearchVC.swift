//
//  RxVC.swift
//  SwiftReference
//
//  Created by baw0803 on 2017. 10. 23..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpObservable()
    }
    
    private func setUpObservable() {
        searchBar.rx.text
            .orEmpty
            .filter { query in
                return query.count > 2
            }
            .debounce(.milliseconds(5), scheduler: MainScheduler.instance)
            .map { query in
                var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=music&entity=song")
                let queryItem = URLQueryItem(name: "term", value: query)
                urlComponents?.queryItems?.append(queryItem)
                return URLRequest(url: (urlComponents?.url)!)
            }
            .flatMapLatest { request in
                return URLSession.shared.rx.json(request: request)
                    .catchAndReturn([])
            }
            .map { json -> [[String: Any]] in
                guard let json = json as? [String: Any], let items = json["results"] as? [[String: Any]] else  {
                    return []
                }
                return items.compactMap{$0}
            }
            .bind(to: self.mainTableView.rx.items) { tableView, row, repo in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel!.text = repo["trackName"] as? String
                cell.detailTextLabel?.text = repo["artistName"] as? String
                return cell
        }.disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


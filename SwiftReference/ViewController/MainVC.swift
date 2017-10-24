//
//  MainVC.swift
//  SwiftReference
//
//  Created by wooky83 on 2017. 10. 18..
//  Copyright © 2017년 wooky83. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    enum Row {
        case rxSwift(String)
        case rxCocoa(String)
    }
    var topicArray: [Row] = []
    @IBOutlet weak var mainTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        topicArray.append(Row.rxSwift("rxSwift"))
        topicArray.append(Row.rxCocoa("rxCoCoa"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MainVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch topicArray[indexPath.row] {
        case .rxSwift(let title):
            cell.textLabel?.text = title
        case .rxCocoa(let title):
            cell.textLabel?.text = title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch topicArray[indexPath.row] {
        case .rxSwift(let title):
            performSegue(withIdentifier: title, sender: nil)
        case .rxCocoa(let title):
            performSegue(withIdentifier: title, sender: nil)
        }
        
    }
    
}


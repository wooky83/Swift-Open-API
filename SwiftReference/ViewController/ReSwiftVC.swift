//
//  ReSwiftVCViewController.swift
//  SwiftReference
//
//  Created by sungwook on 2022/04/25.
//  Copyright © 2022 wooky83. All rights reserved.
//

import UIKit
import ReSwift

class ReSwiftVC: BaseVC, StoreSubscriber {

    typealias StoreSubscriberStateType = AppState
    
    @IBOutlet weak var counterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainStore.subscribe(self)
    }
    
    
    func newState(state: AppState) {
        // when the state changes, the UI is updated to reflect the current state
        counterLabel.text = "\(mainStore.state.counter)"
    }
    
    // when either button is tapped, an action is dispatched to the store
    // in order to update the application state
    @IBAction func downTouch(_ sender: AnyObject) {
        mainStore.dispatch(CounterActionDecrease());
    }
    @IBAction func upTouch(_ sender: AnyObject) {
        mainStore.dispatch(CounterActionIncrease());
    }

}

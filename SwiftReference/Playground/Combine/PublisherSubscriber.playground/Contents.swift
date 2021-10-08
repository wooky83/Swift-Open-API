//: Playground - noun: a place where people can play

import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

do {
    let center = NotificationCenter.default
    let myNotification = Notification.Name("MyNotification")
    
    let publisher = center.publisher(for: myNotification, object: nil)
    
    let subscription = publisher
        .print()
        .sink {
            print("Notification received from a publisher! value is \($0)!")
        }
    
    center.post(name: myNotification, object: nil)
    subscription.cancel()
}

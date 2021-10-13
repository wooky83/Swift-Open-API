//: Playground - noun: a place where people can play

import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

print("-------PassthroughSubject-------")
do  {
    let subject = PassthroughSubject<String, Never>()
    
    subject.send("hi!")
    subject
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    subject.send("Hello")
    subject.send("World")
    
    subject.send(completion: .finished)
    subject.send("Still there?")
}
print("-------CurrentValueSubject-------")
do  {
    let subject = CurrentValueSubject<Int, Never>(0)
    
    subject
        .print()
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    print(subject.value)
    
    subject.send(1)
    subject.send(2)
    
    print(subject.value)
    
    subject.send(completion: .finished)
}
print("-------eraseToAnyPublisher-------")
do  {
    let subject = PassthroughSubject<Int, Never>()
    
    let publisher = subject.eraseToAnyPublisher()
    
    //  publisher.send(0)
    
    publisher
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    subject.send(1)
}


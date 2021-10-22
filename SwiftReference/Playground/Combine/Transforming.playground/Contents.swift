//: Playground - noun: a place where people can play

import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()

// MARK: - Collecting values
do {
    ["A", "B", "C", "D", "E"].publisher
        .collect(2)
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
}

// MARK: - Mapping values
do {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    [123, 4, 56].publisher
        .map {
            formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
        }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

// MARK: - Replacing upstream output
do {
    ["A", nil, "C"].publisher
        .replaceNil(with: "-")
        .map { $0! }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

do  {
    let empty = Empty<Int, Never>()
    
    empty
        .replaceEmpty(with: 1)
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
}

do {
    var dailyGainLoss: Int { .random(in: -10...10) }
    
    let august2019 = (0..<22)
        .map { _ in dailyGainLoss }
        .publisher
    
    august2019
        .scan(50) { latest, current in
            max(0, latest + current)
        }
        .sink(receiveValue: { _ in })
        .store(in: &subscriptions)
}

// MARK: - Flattening publishers
do {
    let charlotte = Chatter(name: "Charlotte", message: "Hi, I'm Charlotte!")
    let james = Chatter(name: "James", message: "Hi, I'm James!")
    
    let chat = CurrentValueSubject<Chatter, Never>(charlotte)
    
    chat
        .flatMap(maxPublishers: .max(2)) { $0.message }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    charlotte.message.value = "Charlotte: How's it going?"
    
    chat.value = james
    
    james.message.value = "James: Doing great. You?"
    charlotte.message.value = "Charlotte: I'm doing fine thanks."
    
    let morgan = Chatter(name: "Morgan",
                         message: "Hey guys, what are you up to?")
    
    chat.value = morgan
    
    charlotte.message.value = "Did you hear something?"
}

public struct Chatter {
  public let name: String
  public let message: CurrentValueSubject<String, Never>
  
  public init(name: String, message: String) {
    self.name = name
    self.message = CurrentValueSubject(message)
  }
}

do {
  let contacts = [
    "603-555-1234": "Florent",
    "408-555-4321": "Marin",
    "217-555-1212": "Scott",
    "212-555-3434": "Shai"
  ]

  func convert(phoneNumber: String) -> Int? {
    if let number = Int(phoneNumber),
      number < 10 {
      return number
    }

    let keyMap: [String: Int] = [
      "abc": 2, "def": 3, "ghi": 4,
      "jkl": 5, "mno": 6, "pqrs": 7,
      "tuv": 8, "wxyz": 9
    ]

    let converted = keyMap
      .filter { $0.key.contains(phoneNumber.lowercased()) }
      .map { $0.value }
      .first

    return converted
  }

  func format(digits: [Int]) -> String {
    var phone = digits.map(String.init)
                      .joined()

    phone.insert("-", at: phone.index(
      phone.startIndex,
      offsetBy: 3)
    )

    phone.insert("-", at: phone.index(
      phone.startIndex,
      offsetBy: 7)
    )

    return phone
  }
  
  func dial(phoneNumber: String) -> String {
    guard let contact = contacts[phoneNumber] else {
      return "Contact not found for \(phoneNumber)"
    }

    return "Dialing \(contact) (\(phoneNumber))..."
  }
  
  let input = PassthroughSubject<String, Never>()

  input
    .map(convert)
    .replaceNil(with: 0)
    .collect(10)
    .map(format)
    .map(dial)
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
  
  "0!1234567".forEach {
    input.send(String($0))
  }
  
  "4085554321".forEach {
    input.send(String($0))
  }
  
  "A1BJKLDGEH".forEach {
    input.send("\($0)")
  }
}

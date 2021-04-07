import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("Drive")

/*
    UI레이어에 reactive 코드를 작성하는 직관적인 방법을 제공하거나 애플리케이션에서 데이터 스트림을 모델링하는 모든 경우
        1. 오류가 없습니다.(오류를 방출하지 않는다는 의미)
        2. observe는 Main scheulder에서 발생합니다.
        3. 부수작용을 공유합니다(shareReplayLatestWhileConnected)
 */

do {
    
    let p = PublishSubject<Int>()
    
    p.asDriver(onErrorJustReturn: 0)
        .drive(onNext: {
            print($0)
        })
    
    p.onNext(2)
    
    let pr = BehaviorRelay<Int>(value: 5)
    
    pr.asDriver()
        .drive(onNext: {
            print($0)
        })
    
    pr.accept(7)
}


//UI요소의 속성을 나타내기위한 Observable/ObservableType을 위한 Trait

do {
    // ControlEvent<Void>
    let _ = UIButton().rx.tap
    
    // ControlProperty<String?>
    let _ = UITextView().rx.text
        
}

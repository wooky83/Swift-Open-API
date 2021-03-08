import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

print("ReplayRelay Subject")

/*
    Relay는 Subject의 wrapper로 스트림이 절대 실패(fail)하거나 종료(complete)되지 않는 것을 보장합니다. RxSwift 6에서는 ReplaySubject를 wrapping한 ReplayRelay를 기존의 BehaviorRelay와 PublishRelay에 추가했습니다.
    ReplayRelay를 생성하는 방법은 ReplaySubject를 생성하는 방법과 완전히 동일합니다.
 */

do {
    let replayRelay = ReplayRelay<Int>.create(bufferSize: 3)
    
    replayRelay.accept(1)
    replayRelay.accept(2)
    replayRelay.accept(3)
    replayRelay.accept(4)
    
    replayRelay
        .subscribe(onNext: {
            print($0)
        })
    
    replayRelay.accept(5)
}

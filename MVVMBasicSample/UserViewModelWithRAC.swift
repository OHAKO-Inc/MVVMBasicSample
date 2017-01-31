//
//  UserViewModelWithRAC.swift
//  MVVMBasicSample
//
//  Created by Yoshikuni Kato on 2016/04/25.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

struct UserViewModelWithRAC {

    let user: User
    
    // output
    let fullName: String
    let image = MutableProperty<UIImage?>(nil)

    // input
    let imageFetchAction: Action<AnyObject?, UIImage?, NoError>
    
    
    init(user: User) {
        self.user = user

        fullName = "\(user.firstName) \(user.lastName)"

        imageFetchAction = Action<AnyObject?, UIImage?, NoError> { (_) -> SignalProducer<UIImage?, NoError> in
            return SignalProducer<UIImage?, NoError> { (observer, disposable) in
                let delay = 1.0 * Double(NSEC_PER_SEC)
                let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) { () -> () in
                    observer.sendNext(UIImage(named: user.imageName))
                    observer.sendCompleted()
                }
            }
        }
        
        image <~ imageFetchAction.values
        
        // for behavior observing
        imageFetchAction.executing.producer.startWithNext { (executing) in
            print("actionExecuting: \(executing)")
        }
        imageFetchAction.enabled.producer.startWithNext { (enabled) in
            print("actionEnabled: \(enabled)")
        }
    }

}

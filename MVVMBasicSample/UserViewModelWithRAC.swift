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

    let fullName: String
    let image = MutableProperty<UIImage?>(nil)
    let imageFetchButtonAction: Action<AnyObject?, Void, NoError> = Action({ (input) -> SignalProducer<Void, NoError> in
        return SignalProducer<(), NoError>({ (sink, disposable) in
            sink.sendNext(())
            sink.sendCompleted()
        })
    })


    init(user: User) {
        self.user = user

        fullName = "\(user.firstName) \(user.lastName)"


        let fetchedImageSignal = imageFetchButtonAction
            .values
            .flatMap(.Merge) { () -> SignalProducer<UIImage?, NoError> in
                return SignalProducer<UIImage?, NoError> { (observer, disposable) in

                    let delay = 1.0 * Double(NSEC_PER_SEC)
                    let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue()) { () -> () in
                        observer.sendNext(UIImage(named: user.imageName))
                        observer.sendCompleted()
                    }

                }
        }

        image <~ fetchedImageSignal
    }

}

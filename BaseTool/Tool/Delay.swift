//
//  Delay.swift
//  IMKeyBoard
//
//  Created by point on 2022/10/12.
//

import Foundation

public typealias Delay_Task = (_ cancel : Bool) -> Void

/**延迟执行**/
@discardableResult
public func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Delay_Task? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }

    var closure: (()->Void)? = task
    var result: Delay_Task?

    let delayedClosure: Delay_Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }

    result = delayedClosure

    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }

    return result

}

public func Delay_Cancel(_ task: Delay_Task?) {
    task?(true)
}


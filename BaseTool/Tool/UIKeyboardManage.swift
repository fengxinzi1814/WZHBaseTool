//
//  UIKeyboardManage.swift
//  WZHBaseTool
//
//  Created by point on 2022/10/12.
//  键盘监听器

import Foundation
import UIKit
import SwiftNotificationCenter
protocol Event_Keyboard {
    func UIKeyboardWillShow(beginFrame: CGRect, endFrame: CGRect , duration: TimeInterval)
    func UIKeyboardWillHidden(beginFrame: CGRect, endFrame: CGRect , duration: TimeInterval)
}

class UIKeyboardSystemNotifictionMediator {
    
    static let mediator = UIKeyboardSystemNotifictionMediator()

    @objc func WillShowKeyboardNotification(notification: NSNotification) {
        guard notification.name == UIResponder.keyboardWillShowNotification
            else { return }
        
        guard let beginFrame = (notification
            .userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        guard let endFrame = (notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        let duration = (notification
                            .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
//        print("当前键盘的开始高度是 \(beginFrame.size.height)")
//        print("当前键盘的结束高度是 \(endFrame.size.height)")
        Broadcaster.notify(Event_Keyboard.self) {
            $0.UIKeyboardWillShow(beginFrame: beginFrame, endFrame: endFrame,duration: duration)
        }
    }
    
    @objc func WillHiddenKeyboardNotification(notification: NSNotification) {
        guard notification.name == UIResponder.keyboardWillHideNotification
            else { return }
        
        guard let beginFrame = (notification
            .userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        guard let endFrame = (notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        let duration = (notification
                            .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        
        Broadcaster.notify(Event_Keyboard.self) {
            $0.UIKeyboardWillHidden(beginFrame: beginFrame, endFrame: endFrame,duration: duration)
        }
    }
    
    static let register: () = {
        NotificationCenter.default.addObserver(mediator, selector: #selector(WillShowKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(mediator, selector: #selector(WillHiddenKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }()
    
    
    deinit {
        // 移除键盘监听
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

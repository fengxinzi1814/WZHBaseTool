//
//  Extension+UIApplication.swift
//  IMKeyBoard
//
//  Created by 汪志浩 on 2022/10/13.
//

import Foundation
import UIKit

extension UIApplication {
    /**获取当前的window**/
   static func currentWindow() -> UIWindow? {

     if #available(iOS 14.0, *) {

      if let window = UIApplication.shared.connectedScenes.map({$0 as? UIWindowScene}).compactMap({$0})

       .first?.windows.first {

       return window

      }else if let window = UIApplication.shared.delegate?.window {

       return window

      }else{

       return nil

      }

     } else if #available(iOS 13.0, *) {

      if let window = UIApplication.shared.connectedScenes

       .filter({$0.activationState == .foregroundActive})

       .map({$0 as? UIWindowScene})

       .compactMap({$0})

       .first?.windows

       .filter({$0.isKeyWindow}).first{

       return window

      }else if let window = UIApplication.shared.delegate?.window {

       return window

      }else{

       return nil

      }

     }else{

      if let window = UIApplication.shared.delegate?.window {

       return window

      }else{

       return nil

      }

     }

    }
    
    /**获取当前底部安全区域的高度**/
    static func safeAreaInsets_Bottom() -> CGFloat{
        guard let window = self.currentWindow() else {return 0}
                
        return window.safeAreaInsets.bottom
    }
    
    /**当前最顶层的 VC**/
    static func k_currentViewController() -> UIViewController
    {
        if let rootVC = self.currentWindow()?.rootViewController {//获取到当前的窗口
            return self.k_currentViewController(from: rootVC)
        } else {
            return UIViewController()
        }
    }
    
    static func k_currentViewController(from fromVC:UIViewController) -> UIViewController
    {
        if fromVC.isKind(of: UINavigationController.self) {
            let navigationController = fromVC as! UINavigationController
            return k_currentViewController(from: navigationController.viewControllers.last!)
        }
        else if fromVC.isKind(of: UITabBarController.self) {
            let tabBarController = fromVC as! UITabBarController
            return k_currentViewController(from: tabBarController.selectedViewController!)
        }
        else if let vc = fromVC.presentedViewController {
            return k_currentViewController(from:vc)
        }
        else {
            return fromVC
        }
    }
    
}

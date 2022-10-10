//
//  VCExtension.swift
//  ShiGuangJiaSwift
//
//  Created by 汪志浩 on 2022/7/20.
//

import Foundation
import UIKit

extension UIViewController {
    func navHeight() -> CGFloat {
        return navigationController?.navigationBar.frame.size.height ?? 0
    }
    
    //  A页面 弹出 登录页面B
    //  presentedViewController:    A页面
    //  presentingViewController:   B页面
    
    func k_toLastViewController(animated:Bool)
    {
        if self.navigationController != nil
        {
            if self.navigationController?.viewControllers.count == 1
            {
                self.dismiss(animated: animated, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: animated)
            }
        }
        else if self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
    /**当前最顶层的 VC**/
    static func k_currentViewController() -> UIViewController
    {
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            return self.wr_currentViewController(from: rootVC)
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

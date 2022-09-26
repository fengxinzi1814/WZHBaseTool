//
//  Extension+NSObject.swift
//  ShiGuangJiaSwift
//
//  Created by 汪志浩 on 2022/9/26.
//

import Foundation

// MARK: Additions
extension NSObject {
    // MARK: ASSIGN 类型的属性的添加与获取
    func k_getAssociatedObjectWithKey(ckey : UnsafeMutableRawPointer) -> Any? {
        return objc_getAssociatedObject(self, ckey)
    }
    
    func k_setAssociatedAssignObject(cValue : Any ,ckey : UnsafeMutableRawPointer) {
        objc_setAssociatedObject(self,ckey,cValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    func k_setAssociatedRetainObject(cValue : Any ,ckey : UnsafeMutableRawPointer) {
        objc_setAssociatedObject(self,ckey,cValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func k_setAssociatedCopyObject(cValue : Any ,ckey : UnsafeMutableRawPointer) {
        objc_setAssociatedObject(self,ckey,cValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    
    func k_setAssociatedObject(cValue : Any ,ckey : UnsafeMutableRawPointer ,policy:objc_AssociationPolicy) {
        objc_setAssociatedObject(self,ckey,cValue, policy)
    }
    
}

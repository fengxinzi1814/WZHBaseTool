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
    /**
     C Syntax                                 Swift Syntax
     
     const Type *                         UnsafePointer
     Type *                                   UnsafeMutablePointer
     Type * const *                      UnsafePointer
     Type * __strong *               UnsafeMutablePointer
     Type **                                 AutoreleasingUnsafeMutablePointer
     const void *                        UnsafeRawPointer
     void *                                    UnsafeMutableRawPointer
     
     */
    
    func k_getAssociatedObjectWithKey(ckey : UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self, ckey)
    }
    
    func k_setAssociatedAssignObject(cValue : Any ,ckey : UnsafeRawPointer) {
        objc_setAssociatedObject(self,ckey,cValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
    
    func k_setAssociatedRetainObject(cValue : Any ,ckey : UnsafeRawPointer) {
        objc_setAssociatedObject(self,ckey,cValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func k_setAssociatedCopyObject(cValue : Any ,ckey : UnsafeRawPointer) {
        objc_setAssociatedObject(self,ckey,cValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    
    func k_setAssociatedObject(cValue : Any ,ckey : UnsafeRawPointer ,policy:objc_AssociationPolicy) {
        objc_setAssociatedObject(self,ckey,cValue, policy)
    }
    
}

//
//  Extension+View.swift
//  ShiGuangJiaSwift
//
//  Created by 汪志浩 on 2022/7/12.
//

import Foundation


extension UIView{
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}


// MARK: Frame

extension UIView {
    var ls_x : CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var curRect = self.frame;
            if (curRect.origin.x != newValue) {
                curRect.origin.x = newValue;
                self.frame = curRect;
            }
        }
    }
    var ls_y : CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var curRect = self.frame;
            if (curRect.origin.y != newValue) {
                curRect.origin.y = newValue;
                self.frame = curRect;
            }
        }
    }
    var ls_width : CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            var curRect = self.frame;
            if (curRect.size.width != newValue) {
                curRect.size.width = newValue;
                self.frame = curRect;
            }
        }
    }
    var ls_height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var curRect = self.frame;
            if (curRect.size.height != newValue) {
                curRect.size.height = newValue;
                self.frame = curRect;
            }
        }
    }
    var ls_origin : CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var curRect = self.frame;
            if (!CGPointEqualToPoint(curRect.origin, newValue)) {
                curRect.origin = newValue;
                self.frame = curRect;
            }
        }
    }
    var ls_size : CGSize{
        get{
            return self.frame.size
        }
        set{
            var curRect = self.frame;
            if (!CGSizeEqualToSize(curRect.size, newValue)) {
                curRect.size = newValue;
                self.frame = curRect;
            }
        }
    }
    var ls_right : CGFloat { // (x + width).
        get{
            return CGRectGetMaxX(self.frame)
        }
    }
    var ls_bottom: CGFloat {  // (y + height).
        get{
            return CGRectGetMaxY(self.frame)
        }
    }
    var ls_centerX: CGFloat {   // (x + width/2).
        get{
            return CGRectGetMidX(self.frame)
        }
        set{
            var curCenter = self.center
            if (curCenter.x != newValue) {
                curCenter.x = newValue;
                self.center = curCenter;
            }
        }
    }
    var ls_centerY: CGFloat {   // (y + height/2).
        get{
            return CGRectGetMidY(self.frame)
        }
        set{
            var curCenter = self.center
            if (curCenter.y != newValue) {
                curCenter.y = newValue;
                self.center = curCenter;
            }
        }
    }
    
}


// MARK: Constraint

extension UIView {
    func ls_constraintForAttribute(attribute : NSLayoutConstraint.Attribute )->NSLayoutConstraint?{
        var constraintArray : [NSLayoutConstraint]
        
        if (attribute == .width || attribute == .height) {
            constraintArray = self.constraints
        } else {
            constraintArray = self.superview?.constraints ?? []
        }
            
       let fillteredArray =  constraintArray.filter{
           return $0.firstAttribute == attribute && ($0.firstItem as! NSObject == self || $0.secondItem as! NSObject == self)
        }
        
        return fillteredArray.first
        
    }
    
    var ls_constraintTop : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .top)
    }
    
    var ls_constraintBottom : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .bottom)
    }
    
    var ls_constraintLeading : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .left)
    }
    
    var ls_constraintTrailing : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .right)
    }
    
    var ls_constraintWidth : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .width)
    }
    
    var ls_constraintHeight : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .height)
    }
    
    var ls_constraintCenterX : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .centerX)
    }
    
    var ls_constraintCenterY : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .centerY)
    }
    ///基线指的的例如UILabel 的 文字的 Bottom 而不是控件的 bottom
    var ls_constraintBaseline : NSLayoutConstraint? {
        return self.ls_constraintForAttribute(attribute: .lastBaseline)
    }
    
    func ls_layoutPinnedToSuperview() {
        
        guard let superView =  self.superview else {return}
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        
    }
    
}


// MARK: Layer
extension UIView {
    @IBInspectable var ls_cornerRadius :  CGFloat {
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            if self.isKind(of: UIButton.self) || self.isKind(of: UIImageView.self) {
                self.layer.masksToBounds = (ls_cornerRadius > 0);
            }
        }
    }
    
    @IBInspectable var ls_masksToBounds : Bool {
        get{
            return self.layer.masksToBounds
        }
        set{
            if !self.isKind(of: UIButton.self) && !self.isKind(of: UIImageView.self) {
                self.layer.masksToBounds = newValue
            }
        }
    }
    
    @IBInspectable var ls_borderWidth : CGFloat {
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var ls_borderColor : UIColor? {
        get{
            guard let borderColor = self.layer.borderColor else {return nil}
            return UIColor(cgColor: borderColor)
        }
        set{
            guard let borderColor = newValue?.cgColor else {return }
            self.layer.borderColor = borderColor
        }
    }
    
    @IBInspectable var ls_shadowColor : UIColor? {
        get{
            guard let shadowColor = self.layer.shadowColor else {return nil}
            return UIColor(cgColor: shadowColor)
        }
        set{
            guard let shadowColor = newValue?.cgColor else {return }
            self.layer.shadowColor = shadowColor
        }
    }
    
    @IBInspectable var ls_shadowOpacity : Float {
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var ls_shadowOffset : CGSize {
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var ls_shadowRadius : CGFloat {
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var ls_shadowPath : Bool {
        get{
            guard self.layer.shadowRadius != 0 else {return false}
            return true
        }
        set{
            self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
        }
    }
    
    
}


// MARK: GestureRecognizer
extension UIView {
    /**添加 tap 事件
     *新版的Swift闭包做参数默认是@noescaping，不再是@escaping。所以如果函数里异步执行该闭包，要添加@escaping。否则报错：Closure use of non-escaping parameter 'xxx' may allow it to escape.*
     **/
    func ls_addTapGes(cb: ((_ cTapGes:UITapGestureRecognizer)->())?) {
        if !self.isUserInteractionEnabled { self.isUserInteractionEnabled = !self.isUserInteractionEnabled}
        guard let cb = cb else {return}
        // #function 当前方法名 , 例如 OC 中的_cmd
        if ((self.k_getAssociatedObjectWithKey(ckey: #function) as? UITapGestureRecognizer ) == nil) { //如果 view 本身不存在这个tap 事件,添加一个 curGesture 的属性
            let curGesture = UITapGestureRecognizer(target: self, action: #selector(ls_handleTapGes(tapGes:)))
            self.addGestureRecognizer(curGesture)
            self.k_setAssociatedRetainObject(cValue: curGesture, ckey: #function)
        }
        let handKey = NSStringFromSelector(#selector(ls_handleTapGes(tapGes:))) //handKey    String    "ls_handleTapGesWithTapGes:"
        self.k_setAssociatedRetainObject(cValue: cb, ckey:"ls_handleTapGes")
    }
    
    ///触发点击事件
    @objc func ls_handleTapGes(tapGes : UITapGestureRecognizer) {
        let handKey = #function  //handKey    String    "ls_handleTapGes(tapGes:)"
        let cb1 = self.k_getAssociatedObjectWithKey(ckey:"ls_handleTapGes")
        let cb = self.k_getAssociatedObjectWithKey(ckey:"ls_handleTapGes") as? (_ cTapGes: UITapGestureRecognizer) -> ()
        cb?(tapGes)
    }
    
    
    /**添加  长按 事件
     *新版的Swift闭包做参数默认是@noescaping，不再是@escaping。所以如果函数里异步执行该闭包，要添加@escaping。否则报错：Closure use of non-escaping parameter 'xxx' may allow it to escape.*
     **/
    func ls_addLongPressGes(cb:@escaping (_ cLongPressGes:UILongPressGestureRecognizer)->()) {
        if !self.isUserInteractionEnabled { self.isUserInteractionEnabled = !self.isUserInteractionEnabled}
        
        // #function 当前方法名 , 例如 OC 中的_cmd
        if ((self.k_getAssociatedObjectWithKey(ckey: #function) as? UILongPressGestureRecognizer ) == nil) { //如果 view 本身不存在这个tap 事件,添加一个 curGesture 的属性
            let curGesture = UILongPressGestureRecognizer(target: self, action: #selector(ls_handleLongPressGes(longPressGes:)))
            self.addGestureRecognizer(curGesture)
            self.k_setAssociatedRetainObject(cValue: curGesture, ckey: #function)
        }
        self.k_setAssociatedCopyObject(cValue: cb, ckey:NSStringFromSelector(#selector(ls_handleLongPressGes(longPressGes:))))
    }
    
    ///触发长按事件
    @objc func ls_handleLongPressGes(longPressGes : UILongPressGestureRecognizer) {
        let cb = self.k_getAssociatedObjectWithKey(ckey: #function) as? (_ cTapGes: UILongPressGestureRecognizer) -> ()
        cb?(longPressGes)
    }
}

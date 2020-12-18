//
//  Extensions.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/26.
//

import UIKit

extension UIViewController {
    /**
     * @brief :  Alert 창 보이기
     * @param :  String, String
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/10/26
     */
    func okAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    func anchor (top: NSLayoutYAxisAnchor?,
                 leading: NSLayoutXAxisAnchor?,
                 trailing:NSLayoutXAxisAnchor?,
                 bottom: NSLayoutYAxisAnchor?,
                 padTop: CGFloat,
                 padLeft: CGFloat,
                 padRight: CGFloat,
                 padBottom: CGFloat,
                 width: CGFloat,
                 height: CGFloat) {
                
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padTop).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padLeft).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padBottom).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

/**
 * @brief :  우선순위 extension
 * @param :  setting 할 우선순위 ( 1000, 750, 500, 250, etc...)
 * @return :  priority
 * @see : -
 * @author : Jungwon Cha
 * @date :  2020/11/20
 */
extension NSLayoutConstraint {
    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}


/**
 * @brief :  프로퍼티 접근 패턴 정의, Autolayout사용시 translatesAutoresizingMaskIntoConstraints 값 false로 설정해주니 안써줘도 됨
 *          Property 앞에 @UseAutoLayout 붙이면 됨
 * @param :  -
 * @return :  -
 * @see : var 타입만 사용가능
 * @author : Jungwon Cha
 * @date :  2020/11/20
 */
@propertyWrapper
public struct UseAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}


extension UIColor {
    static let highlightedLabel = UIColor.label.withAlphaComponent(0.8)
    
    var highlighted: UIColor { withAlphaComponent(0.8) }
    var image: UIImage {
        let pixel = CGSize(width: 1, height: 1)
        return UIGraphicsImageRenderer(size: pixel).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: pixel))
        }
    }
}

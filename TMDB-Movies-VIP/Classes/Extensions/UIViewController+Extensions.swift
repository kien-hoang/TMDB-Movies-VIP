//
//  UIViewController+Extensions.swift
//  
//
//  Created by Bradley Hoang on 28/12/2022.
//

import UIKit

extension UIViewController {
//    static func initViewController() -> Self {
//        let className = String(describing: classForCoder())
//        let storyboard = UIStoryboard(name: className, bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: className) as! Self
//        return controller
//    }
    
    
    
    func hideKeyboardWhenTappedAround(isCancelTouchInView: Bool = false) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = isCancelTouchInView
    }
}

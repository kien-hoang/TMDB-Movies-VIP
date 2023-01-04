//
//  UIApplication+Extensions.swift
//  
//
//  Created by Bradley Hoang on 29/12/2022.
//

import UIKit

extension UIApplication {
    var mainKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
}

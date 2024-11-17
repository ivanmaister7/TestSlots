//
//  UIResponder.swift
//  TestSlots
//
//  Created by ivan on 17.11.2024.
//

import UIKit

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

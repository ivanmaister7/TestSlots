//
//  CALayerExtension.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit

extension CALayer {
    func applyShadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize = .zero) {
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowRadius = radius
        shadowOffset = offset
        masksToBounds = false
    }
}

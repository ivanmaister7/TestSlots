//
//  StringExtension.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import UIKit

extension String {
    func openURL(){
        if let url = URL(string: self) {
            UIApplication.shared.open(url)
        }
    }
}

//
//  UIFontExtension.swift
//  TestSlots
//
//  Created by ivan on 05.11.2024.
//

import UIKit

extension UIFont {
    private static func getFontName(name: String) -> String {
        
        let subFontUrl = Bundle.main.url(forResource: name, withExtension: "ttf")!
        let fontPath = subFontUrl.path as CFString
        let fontURL = CFURLCreateWithFileSystemPath(nil, fontPath, CFURLPathStyle.cfurlposixPathStyle, false)
        
        guard let fontDataProvider = CGDataProvider(url: fontURL!) else {
            return ""
        }
        
        if let font = CGFont(fontDataProvider) {
            if let postScriptName = font.postScriptName as String? {
                return postScriptName
            }
        }
        
        return ""
    }
    
    private static func getFont(fontName: String, size: CGFloat) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size)
        let font = UIFont(name: getFontName(name: fontName), size: size) ?? systemFont
        return font
    }
    
    static func getJudson700(size: CGFloat) -> UIFont {
        return getFont(fontName: "Judson-Bold", size: size)
    }
    
    static func getSuranna400(size: CGFloat) -> UIFont {
        return getFont(fontName: "Suranna-Regular", size: size)
    }
    
    static func getInter700(size: CGFloat) -> UIFont {
        return getFont(fontName: "Inter-Bold", size: size)
    }
    
    static func getKohSantepheap700(size: CGFloat) -> UIFont {
        return getFont(fontName: "KohSantepheap-Bold", size: size)
    }
    
    static func getOpenSans700(size: CGFloat) -> UIFont {
        return getFont(fontName: "OpenSans-Bold", size: size)
    }
}

//
//  UIFont+Ext.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit

extension UIFont {
    
    static let appTitleFont = UIFont.preferredFont(for: .largeTitle, weight: .heavy)
    static let appBodyFont = UIFont.preferredFont(for: .body, weight: .semibold)
    static let appSubtitleFont = UIFont.preferredFont(for: .callout, weight: .semibold)
    static let appButtonFont = UIFont.preferredFont(for: .callout, weight: .bold)
    
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}

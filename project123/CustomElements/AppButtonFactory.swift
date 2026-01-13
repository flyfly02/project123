//
//  AppBarButtonItem.swift
//  project123
//
//  Created by Илья Богуш on 9.01.26.
//

import Foundation
import UIKit

struct AppButtonFactory {
    static func createBarItem(_ title: String, _ target: Any? = nil, _ action: Selector? = nil) -> UIBarButtonItem {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.appGreen!,
            .font: UIFont.nunitoExtraBold(size: 17)!
        ]
        let button = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        button.setTitleTextAttributes(attributes, for: .normal)
        return button
    }
    
    static func createChangePlayerScore(_ value: Int, _ height: CGFloat) -> UIButton {
        let button = UIButton()
            button.backgroundColor = .appGreen
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = height / 2
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.appButtonShadow
            shadow.shadowOffset = CGSize(width: 0, height: 2)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.nunitoExtraBold(size: 50)!,
                .foregroundColor: UIColor.white,
                .shadow: shadow
            ]
            
        let attributedText = NSAttributedString(string: String(value), attributes: attributes)
            button.setAttributedTitle(attributedText, for: .normal)
            
            return button
    }
}

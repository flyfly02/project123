//
//  AppBarButtonItem.swift
//  project123
//
//  Created by Илья Богуш on 9.01.26.
//

import Foundation
import UIKit

struct AppButtonFactory {
    
    enum Buttontype {
        case smallButton
        case bigButton
    }
    static func createBarItem(_ title: String, _ target: Any? = nil, _ action: Selector? = nil) -> UIBarButtonItem {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.appGreen!,
            .font: UIFont.nunitoExtraBold(size: 17)!
        ]
        let button = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        button.setTitleTextAttributes(attributes, for: .normal)
        return button
    }
    
    static func createChangePlayerScore(_ value: Int, _ size: CGFloat, _ font: UIFont) -> UIButton {
        let button = UIButton()
            button.backgroundColor = .appGreen
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: size).isActive = true
            button.widthAnchor.constraint(equalToConstant: size).isActive = true
            button.layer.cornerRadius = size / 2
        let shadow = NSShadow()
            shadow.shadowColor = UIColor.appButtonShadow
            shadow.shadowOffset = CGSize(width: 0, height: 2)
        let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.white,
                .shadow: shadow
            ]
        var stringValue: String = String(value)
        if value > 0 {
            stringValue.insert("+", at: stringValue.startIndex)
        }
        let attributedText = NSAttributedString(string: stringValue, attributes: attributes)
            button.setAttributedTitle(attributedText, for: .normal)
//        button.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
            
        return button
    }
    
    static func createImageButton(_ named: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: named), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.widthAnchor.constraint(equalToConstant: 34).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

extension AppButtonFactory {
    private func buttonTapped() -> () {
        
    }
}

//
//  AppBarButtonItem.swift
//  project123
//
//  Created by Илья Богуш on 9.01.26.
//

import Foundation
import UIKit

final class AppBarButtonItem {
    static func createButton(_ title: String, _ target: Any? = nil, _ action: Selector? = nil) -> UIBarButtonItem {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.appGreen!,
            .font: UIFont.nunitoExtraBold(size: 17)!
        ]
        let button = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        button.setTitleTextAttributes(attributes, for: .normal)
        return button
    }
}

//
//  Colors.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import UIKit

extension UIColor {
    private static func color(named: String) -> UIColor? {
        UIColor(named: named, in: Bundle.main, compatibleWith: nil)
    }
    
    static let appBackgroundColor = color(named: "app-background-color") ?? .clear
    static let listItemBackgroundColor = color(named: "list-item-background-color") ?? .clear
    static let listItemseparatorColor = color(named: "list-item-separator-color") ?? .clear
    static let imageBackgroundColor = color(named: "image-background-color") ?? .clear
    static let versusLabelColor = color(named: "versus-label-color") ?? .clear
    static let badgeRunningStatusColor = color(named: "badge-running-status-color") ?? .clear
    static let badgeUpcomingStatusColor = color(named: "badge-upcoming-status-color") ?? .clear
    
}

//
//  Images.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation
import UIKit

extension UIImage {
    private static func image(named: String) -> UIImage? {
        UIImage(named: named, in: Bundle.main, compatibleWith: nil)
    }
    
    static let teamLogoPlaceholder = image(named: "team-logo-placeholder")
    static let rectanglePlaceholder = image(named: "rectangle-placeholder")
    static let arrowLeft = image(named: "ic-arrow-left")
}

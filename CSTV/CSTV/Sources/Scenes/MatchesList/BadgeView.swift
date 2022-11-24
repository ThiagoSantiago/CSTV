//
//  BadgeView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 22/11/22.
//

import Foundation
import UIKit

enum BadgeStatus {
    case running
    case upComing
}

final class BadgeView: UIView {
    
    private lazy var badgeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(codes:) has not been implemented")
    }
    
    func setBadgeTitle(_ title: String) {
        badgeLabel.text = title
    }
    
    func updateStatus(status: BadgeStatus) {
        switch status {
        case .running:
            backgroundColor = .badgeRunningStatusColor
        case .upComing:
            backgroundColor = .badgeUpcomingStatusColor
        }
    }
}

extension BadgeView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(badgeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: Space.base04.rawValue),
            badgeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Space.base01.rawValue),
            badgeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Space.base03.rawValue),
            badgeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Space.base01.rawValue),
        ])
    }
}

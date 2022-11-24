//
//  TeamLogoAndTitleView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 22/11/22.
//

import Foundation
import SDWebImage
import UIKit

fileprivate extension CGFloat {
    static let cornerRadius: CGFloat = 30
    static let teamLogoSize: CGFloat = 60
}

final class TeamLogoAndNameView: UIView {
    private lazy var teamLogoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .regularH7
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
    
    func setContent(teamName: String, teamImage: String) {
        teamNameLabel.text = teamName
        teamLogoImage.sd_setImage(with: URL(string: teamImage), placeholderImage: .teamLogoPlaceholder)
        buildLayout()
    }
}

extension TeamLogoAndNameView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(teamLogoImage)
        addSubview(teamNameLabel)
    }
    
    func configureViews() {
        backgroundColor = .clear
        
        teamLogoImage.layer.cornerRadius = .cornerRadius
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            teamLogoImage.topAnchor.constraint(equalTo: topAnchor),
            teamLogoImage.widthAnchor.constraint(equalToConstant: .teamLogoSize),
            teamLogoImage.heightAnchor.constraint(equalToConstant: .teamLogoSize),
            teamLogoImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            teamNameLabel.topAnchor.constraint(equalTo: teamLogoImage.bottomAnchor, constant: Space.base02.rawValue),
            teamNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Space.base03.rawValue),
            teamNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Space.base03.rawValue)
        ])
    }
}

//
//  TeamLogoAndTitleView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 22/11/22.
//

import Foundation
import UIKit

final class TeamLogoAndNameView: UIView {
    private lazy var teamLogoImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .imageBackgroundColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = teamName
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamName: String
    private let teamLogoUrl: String
    
    init(teamName: String, teamLogoUrl: String) {
        self.teamName = teamName
        self.teamLogoUrl = teamLogoUrl
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(codes:) has not been implemented")
    }
}

extension TeamLogoAndNameView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(teamLogoImage)
        addSubview(teamNameLabel)
    }
    
    func configureViews() {
        backgroundColor = .clear
        
        teamLogoImage.layer.cornerRadius = 30
        
        guard let logoUrl = URL(string: teamLogoUrl) else { return }
        ImageDownloader.shared.loadImage(from: logoUrl) { [weak self] teamLogo in
            self?.teamLogoImage.image = teamLogo
            self?.teamLogoImage.backgroundColor = .clear
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            teamLogoImage.topAnchor.constraint(equalTo: topAnchor),
            teamLogoImage.widthAnchor.constraint(equalToConstant: 60),
            teamLogoImage.heightAnchor.constraint(equalToConstant: 60),
            teamLogoImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            teamNameLabel.topAnchor.constraint(equalTo: teamLogoImage.bottomAnchor, constant: Space.base02.rawValue),
            teamNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Space.base03.rawValue),
            teamNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Space.base03.rawValue)
        ])
    }
}

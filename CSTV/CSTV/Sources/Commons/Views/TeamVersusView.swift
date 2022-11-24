//
//  TeamVersusView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 22/11/22.
//

import Foundation
import UIKit

fileprivate extension CGFloat {
    static let teamViewWidth: CGFloat = 120
}

struct TeamVersusViewModel {
    let teamName: String
    let teamLogoUrl: String
}

final class TeamVersusView: UIView {
    private lazy var teamOne: TeamLogoAndNameView = {
        let teamView = TeamLogoAndNameView()
        teamView.translatesAutoresizingMaskIntoConstraints = false
        return teamView
    }()
    
    private lazy var teamTwo: TeamLogoAndNameView = {
        let teamView = TeamLogoAndNameView()
        teamView.translatesAutoresizingMaskIntoConstraints = false
        return teamView
    }()
    
    private lazy var versusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .versusLabelColor
        label.text = "VS"
        label.textAlignment = .center
        label.font = .h6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Space.base01.rawValue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(codes:) has not been implemented")
    }
    
    func setContent(firstOponent: TeamVersusViewModel, secondOponent: TeamVersusViewModel) {
        teamOne.setContent(teamName: firstOponent.teamName, teamImage: firstOponent.teamLogoUrl)
        teamTwo.setContent(teamName: secondOponent.teamName, teamImage: secondOponent.teamLogoUrl)
        
        buildLayout()
    }
}

extension TeamVersusView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(teamOne)
        addSubview(versusLabel)
        addSubview(teamTwo)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            versusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            versusLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Space.base04.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            teamOne.topAnchor.constraint(equalTo: topAnchor),
            teamOne.rightAnchor.constraint(equalTo: versusLabel.leftAnchor, constant: -Space.base00.rawValue),
            teamOne.widthAnchor.constraint(greaterThanOrEqualToConstant: .teamViewWidth),
        ])
        
        NSLayoutConstraint.activate([
            teamTwo.topAnchor.constraint(equalTo: topAnchor),
            teamTwo.leftAnchor.constraint(equalTo: versusLabel.rightAnchor, constant: Space.base00.rawValue),
            teamTwo.widthAnchor.constraint(equalToConstant: .teamViewWidth),
        ])
    }
}

//
//  TeamVersusView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 22/11/22.
//

import Foundation
import UIKit

struct TeamVersusViewModel {
    let teamName: String
    let teamLogoUrl: String
}

final class TeamVersusView: UIView {
    private let teamOneData: TeamVersusViewModel
    private let teamTwoData: TeamVersusViewModel
    
    private lazy var teamOne: TeamLogoAndNameView = {
        let teamView = TeamLogoAndNameView(teamName: teamOneData.teamName, teamLogoUrl: teamOneData.teamLogoUrl)
        teamView.translatesAutoresizingMaskIntoConstraints = false
        return teamView
    }()
    
    private lazy var teamTwo: TeamLogoAndNameView = {
        let teamView = TeamLogoAndNameView(teamName: teamTwoData.teamName, teamLogoUrl: teamTwoData.teamLogoUrl)
        teamView.translatesAutoresizingMaskIntoConstraints = false
        return teamView
    }()
    
    private lazy var versusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .versusLabelColor
        label.text = "vs"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
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
    
    init(teamOne: TeamVersusViewModel, teamTwo: TeamVersusViewModel) {
        self.teamOneData = teamOne
        self.teamTwoData = teamTwo
        super.init(frame: .zero)
        
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(codes:) has not been implemented")
    }
}

extension TeamVersusView: ViewConfiguration {
    func buildViewHierarchy() {
        stackView.addArrangedSubview(teamOne)
        stackView.addArrangedSubview(versusLabel)
        stackView.addArrangedSubview(teamTwo)
        
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            versusLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}

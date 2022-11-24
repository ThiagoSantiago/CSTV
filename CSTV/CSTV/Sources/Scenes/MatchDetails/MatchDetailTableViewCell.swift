//
//  MatchDetailTableViewCell.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 24/11/22.
//

import Foundation
import SDWebImage

fileprivate extension CGFloat {
    static let leagueImageSize: CGFloat = 16
    static let teamViewHeight: CGFloat = 120
}

final class MatchDetailTableViewCell: UITableViewCell {
    static let identifier = "MatchDetailTableViewCell"
    
    private lazy var teamVersusView: TeamVersusView = {
        let teamView = TeamVersusView()
        teamView.translatesAutoresizingMaskIntoConstraints = false
        return teamView
    }()
    
    private lazy var beginTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldH7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstTeamPlayers: PlayersView = {
        let playersView = PlayersView()
        playersView.translatesAutoresizingMaskIntoConstraints = false
        return playersView
    }()
    
    private lazy var secondTeamPlayers: PlayersView = {
        let playersView = PlayersView()
        playersView.translatesAutoresizingMaskIntoConstraints = false
        return playersView
    }()
    
    private lazy var playersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Space.base01.rawValue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MatchDetailsData, teams: [TeamDetailsData]) {
        beginTimeLabel.text = getFormattedDate(date: model.beginTime)
        
        let firstTeamModel = TeamVersusViewModel(teamName: model.firstTeam.name, teamLogoUrl: model.firstTeam.imageUrl)
        let secondTeamModel = TeamVersusViewModel(teamName: model.secondTeam.name, teamLogoUrl: model.secondTeam.imageUrl)
        
        teamVersusView.setContent(firstOponent: firstTeamModel, secondOponent: secondTeamModel)
        
        if teams.count == 2 {
            if teams[0].teamId == model.firstTeam.id {
                firstTeamPlayers.setContent(players: teams[0].players, alignment: .left)
                secondTeamPlayers.setContent(players: teams[1].players, alignment: .right)
            } else {
                firstTeamPlayers.setContent(players: teams[1].players, alignment: .left)
                secondTeamPlayers.setContent(players: teams[0].players, alignment: .right)
            }
        }
    }
    
    private func getFormattedDate(date: String) -> String {
        guard let dateFormatted = date.getDateFromString() else { return date}
        
        if Calendar.current.isDateInToday(dateFormatted) {
            return "Hoje, \(date.formatDateStringToStringFormat(toFormat: "HH:mm"))"
        } else if Calendar.current.isDateInTomorrow(dateFormatted) {
            return date.formatDateStringToStringFormat(toFormat: "E HH:mm")
        } else {
            return date.formatDateStringToStringFormat(toFormat: "dd.MM HH:mm")
        }
    }
}

extension MatchDetailTableViewCell: ViewConfiguration {
    func configureViews() {
        backgroundColor = .clear
    }
    
    func buildViewHierarchy() {
        playersStackView.addArrangedSubview(firstTeamPlayers)
        playersStackView.addArrangedSubview(secondTeamPlayers)
        
        addSubview(teamVersusView)
        addSubview(beginTimeLabel)
        addSubview(playersStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            teamVersusView.topAnchor.constraint(equalTo: topAnchor, constant: Space.base06.rawValue),
            teamVersusView.centerXAnchor.constraint(equalTo: centerXAnchor),
            teamVersusView.heightAnchor.constraint(equalToConstant: .teamViewHeight),
        ])
        
        NSLayoutConstraint.activate([
            beginTimeLabel.topAnchor.constraint(equalTo: teamVersusView.bottomAnchor, constant: -Space.base01.rawValue),
            beginTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            beginTimeLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: Space.base05.rawValue),
            beginTimeLabel.rightAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: -Space.base05.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            playersStackView.topAnchor.constraint(equalTo: beginTimeLabel.bottomAnchor, constant: Space.base04.rawValue),
            playersStackView.leftAnchor.constraint(equalTo: leftAnchor),
            playersStackView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}

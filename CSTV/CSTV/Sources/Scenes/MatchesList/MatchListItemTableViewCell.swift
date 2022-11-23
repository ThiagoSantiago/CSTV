//
//  MatchListItemTableViewCell.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import UIKit

fileprivate extension CGFloat {
    static let cornerRadius: CGFloat = 16
    static let softCornerRadius: CGFloat = 8
    static let leagueImageSize: CGFloat = 16
    static let badgeHeight: CGFloat = 38
}

final class MatchListItemTableViewCell: UITableViewCell {
    static let identifier = "MatchListItemTableViewCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var badgeView: BadgeView = {
        let badge = BadgeView()
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
    
    private lazy var teamVersusView: TeamVersusView = {
        let teamOneViewModel = TeamVersusViewModel(teamName: "BIG Academy", teamLogoUrl: "https://cdn.pandascore.co/images/team/image/126694/big.png")
        let teamTwoViewModel = TeamVersusViewModel(teamName: "Sissi State Punks", teamLogoUrl: "https://cdn.pandascore.co/images/team/image/127933/s_uujc_tn.png")
       let teamView = TeamVersusView(teamOne: teamOneViewModel, teamTwo: teamTwoViewModel)
        teamView.translatesAutoresizingMaskIntoConstraints = false
        return teamView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var leagueImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .imageBackgroundColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var leagueAndSerieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "League + serie"
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    private lazy var leagueStackView: UIStackView = {
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
}

extension MatchListItemTableViewCell: ViewConfiguration {
    func configureViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        badgeView.setBadgeTitle("AGORA")
        badgeView.updateStatus(status: .running)
        
        containerView.backgroundColor = .listItemBackgroundColor
        separatorView.backgroundColor = .listItemseparatorColor
        
        badgeView.layer.cornerRadius = .cornerRadius
        leagueImage.layer.cornerRadius = .softCornerRadius
        containerView.layer.cornerRadius = .cornerRadius
    }
    
    func buildViewHierarchy() {
        leagueStackView.addArrangedSubview(leagueImage)
        leagueStackView.addArrangedSubview(leagueAndSerieLabel)
        
        containerView.addSubview(teamVersusView)
        containerView.addSubview(separatorView)
        containerView.addSubview(leagueStackView)
        containerView.addSubview(badgeView)
        
        addSubview(containerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Space.base05.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            teamVersusView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Space.base06.rawValue),
            teamVersusView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            teamVersusView.bottomAnchor.constraint(greaterThanOrEqualTo: separatorView.topAnchor, constant: -Space.base04.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])

        NSLayoutConstraint.activate([
            leagueStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Space.base01.rawValue),
            leagueStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Space.base02.rawValue),
            leagueStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Space.base02.rawValue),
            leagueStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Space.base02.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            leagueImage.widthAnchor.constraint(equalToConstant: .leagueImageSize),
            leagueImage.heightAnchor.constraint(equalToConstant: .leagueImageSize),
        ])
        
        NSLayoutConstraint.activate([
            badgeView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -Space.base02.rawValue),
            badgeView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: Space.base01.rawValue),
            badgeView.heightAnchor.constraint(equalToConstant: .badgeHeight),
            badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: 54),
        ])
    }
}

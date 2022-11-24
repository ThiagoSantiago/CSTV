//
//  PlayersView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 24/11/22.
//

import Foundation
import UIKit

final class PlayersView: UIView {
    
    private lazy var playersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Space.base02.rawValue
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
    
    func setContent(players: [PlayerData], alignment: CardAligment) {
        for (index, player) in players.enumerated() {
            if index < 5 {
                let cardView = PlayerCardView()
                cardView.setContent(playerData: player, alignment: alignment)
                
                playersStackView.addArrangedSubview(cardView)
            }
        }
    }
}

extension PlayersView: ViewConfiguration {
    func buildViewHierarchy() {
        
        addSubview(playersStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            playersStackView.topAnchor.constraint(equalTo: topAnchor),
            playersStackView.leftAnchor.constraint(equalTo: leftAnchor),
            playersStackView.rightAnchor.constraint(equalTo: rightAnchor),
            playersStackView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width/2)-8),
            playersStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

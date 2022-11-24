//
//  PlayerCardView.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 24/11/22.
//

import Foundation
import UIKit

enum CardAligment {
    case left
    case right
}

fileprivate extension CGFloat {
    static let playerImageSize: CGFloat = 48
    static let cornerRadius: CGFloat = 12
    static let softCornerRadius: CGFloat = 8
    static let viewHeight: CGFloat = 58
}

final class PlayerCardView: UIView {
    private var alignment: CardAligment = .left
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .listItemBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nicknameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .boldH6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playerNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .playerNameColor
        label.textAlignment = .right
        label.font = .regularH7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playerImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(codes:) has not been implemented")
    }
    
    func setContent(playerData: PlayerData, alignment: CardAligment) {
        playerImage.sd_setImage(with: URL(string: playerData.imageURL), placeholderImage: .rectanglePlaceholder)
        nicknameLabel.text = playerData.name
        playerNameLabel.text = "\(playerData.firstName) \(playerData.lastName)"
        
        self.alignment = alignment
        alignment == .left ? setLeftAlignment() : setRightAlignement()
        if alignment == .left {
            nicknameLabel.textAlignment = .right
            playerNameLabel.textAlignment = .right
        } else {
            nicknameLabel.textAlignment = .left
            playerNameLabel.textAlignment = .left
        }
    }
}

extension PlayerCardView: ViewConfiguration {
    func configureViews() {
        playerImage.layer.cornerRadius = .softCornerRadius
        containerView.layer.cornerRadius = .cornerRadius
    }
    
    func buildViewHierarchy() {
        containerView.addSubview(nicknameLabel)
        containerView.addSubview(playerNameLabel)
        containerView.addSubview(playerImage)
        
        addSubview(containerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: .viewHeight),
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Space.base00.rawValue),
            containerView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width/2)),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setRightAlignement() {
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: Space.base03.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            playerImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -Space.base00.rawValue),
            playerImage.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Space.base01.rawValue),
            playerImage.widthAnchor.constraint(equalToConstant: .playerImageSize),
            playerImage.heightAnchor.constraint(equalToConstant: .playerImageSize),
        ])
        
        NSLayoutConstraint.activate([
            nicknameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Space.base02.rawValue),
            nicknameLabel.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: Space.base03.rawValue),
            nicknameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Space.base03.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            playerNameLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor),
            playerNameLabel.rightAnchor.constraint(equalTo: nicknameLabel.rightAnchor, constant: -Space.base01.rawValue),
            playerNameLabel.leftAnchor.constraint(equalTo: nicknameLabel.leftAnchor),
            playerNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Space.base01.rawValue),
        ])
    }
    
    private func setLeftAlignment() {
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: -Space.base01.rawValue),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            playerImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -Space.base00.rawValue),
            playerImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Space.base01.rawValue),
            playerImage.widthAnchor.constraint(equalToConstant: .playerImageSize),
            playerImage.heightAnchor.constraint(equalToConstant: .playerImageSize),
        ])
        
        NSLayoutConstraint.activate([
            nicknameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Space.base02.rawValue),
            nicknameLabel.rightAnchor.constraint(equalTo: playerImage.leftAnchor, constant: -Space.base03.rawValue),
            nicknameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Space.base03.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            playerNameLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor),
            playerNameLabel.leftAnchor.constraint(equalTo: nicknameLabel.leftAnchor, constant: Space.base01.rawValue),
            playerNameLabel.rightAnchor.constraint(equalTo: nicknameLabel.rightAnchor),
            playerNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Space.base01.rawValue),
        ])
    }
}

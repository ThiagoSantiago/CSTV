//
//  MatchDetailsViewController.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation
import UIKit

fileprivate extension CGFloat {
    static let loadSize: CGFloat = 42
    static let backButtonSize: CGFloat = 24
}

final class MatchDetailsViewController: UIViewController {
    
    private lazy var screenTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldH5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrowLeft, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var loadContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: MatchDetailsViewModeling
    
    init(viewModel: MatchDetailsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        buildLayout()
        bindViewModel()
        tableView.register(MatchDetailTableViewCell.self, forCellReuseIdentifier: MatchDetailTableViewCell.identifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch()
    }
    
    private func bindViewModel() {
        viewModel.teams.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.showLoad(isLoading: isLoading)
        }
    }
    
    private func showLoad(isLoading: Bool) {
        loadContainerView.isHidden = !isLoading
        tableView.isHidden = isLoading
    }
    
    @objc
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension MatchDetailsViewController: ViewConfiguration {
    func configureViews() {
        view.backgroundColor = .appBackgroundColor
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        guard let matchData = viewModel.matchData.value else {
            screenTitleLabel.text = ""
            return
        }
        
        if matchData.serieName.isEmpty {
            screenTitleLabel.text = matchData.leagueName
        } else {
            screenTitleLabel.text = "\(matchData.leagueName) + \(matchData.serieName)"
        }
    }
    
    func buildViewHierarchy() {
        loadContainerView.addSubview(loadIndicator)
        
        view.addSubview(backButton)
        view.addSubview(screenTitleLabel)
        view.addSubview(tableView)
        view.addSubview(loadContainerView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: screenTitleLabel.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Space.base05.rawValue),
            backButton.widthAnchor.constraint(equalToConstant: .backButtonSize),
            backButton.heightAnchor.constraint(equalToConstant: .backButtonSize)
        ])
        
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Space.base14.rawValue),
            screenTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenTitleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: Space.base00.rawValue),
            screenTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Space.base05.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor, constant: Space.base00.rawValue),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadContainerView.widthAnchor.constraint(equalToConstant: .loadSize),
            loadContainerView.heightAnchor.constraint(equalToConstant: .loadSize)
        ])
        
        NSLayoutConstraint.activate([
            loadIndicator.topAnchor.constraint(equalTo: loadContainerView.topAnchor),
            loadIndicator.leftAnchor.constraint(equalTo: loadContainerView.leftAnchor),
            loadIndicator.rightAnchor.constraint(equalTo: loadContainerView.rightAnchor),
            loadIndicator.bottomAnchor.constraint(equalTo: loadContainerView.bottomAnchor)
        ])
    }
}

extension MatchDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchDetailTableViewCell.identifier) as? MatchDetailTableViewCell, let matchData = viewModel.matchData.value else {
            return UITableViewCell()
        }
        
        cell.configure(with: matchData, teams: viewModel.teams.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.layer.bounds.height - 100
    }
}

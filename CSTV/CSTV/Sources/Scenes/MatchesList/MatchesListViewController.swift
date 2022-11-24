//
//  MatchesListViewController.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation
import UIKit

fileprivate extension CGFloat {
    static let loadSize: CGFloat = 42
    static let cellHeight: CGFloat = 200
}

final class MatchesListViewController: UIViewController {
    
    private lazy var screenTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Partidas"
        label.font = .h2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let viewModel: MatchesListViewModeling
    
    init(viewModel: MatchesListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        buildLayout()
        bindViewModel()
        tableView.register(MatchListItemTableViewCell.self, forCellReuseIdentifier: MatchListItemTableViewCell.identifier)
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
        viewModel.matches.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.showLoad(isLoading: isLoading)
        }
    }
    
    private func showLoad(isLoading: Bool) {
        loadContainerView.isHidden = !isLoading
    }
}

extension MatchesListViewController: ViewConfiguration {
    func configureViews() {
        view.backgroundColor = .appBackgroundColor
    }
    
    func buildViewHierarchy() {
        loadContainerView.addSubview(loadIndicator)
        
        view.addSubview(screenTitleLabel)
        view.addSubview(tableView)
        view.addSubview(loadContainerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Space.base12.rawValue),
            screenTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Space.base05.rawValue),
            screenTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Space.base05.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor, constant: Space.base05.rawValue),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Space.base05.rawValue),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Space.base05.rawValue),
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

extension MatchesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matches.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchListItemTableViewCell.identifier) as? MatchListItemTableViewCell else {
            return UITableViewCell()
        }
        
        let matchItem = viewModel.matches.value[indexPath.row]
        
        cell.configure(with: matchItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.matches.value.count - 1 &&
            viewModel.isNextPageAvailable() {
            viewModel.fetchNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchSelected = viewModel.matches.value[indexPath.row]
        let matchData = MatchDetailsData(beginTime: matchSelected.beginTime,
                                         firstTeam: matchSelected.firstOponent,
                                         secondTeam: matchSelected.secondOponent,
                                         leagueName: matchSelected.leagueName,
                                         serieName: matchSelected.serieName)
        
        let matchDetailViewController = MatchDetailsFactory.make(matchData: matchData)
        self.navigationController?.pushViewController(matchDetailViewController, animated: true)
    }
}

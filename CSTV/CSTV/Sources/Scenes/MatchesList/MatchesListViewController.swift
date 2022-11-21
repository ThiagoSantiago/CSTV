//
//  MatchesListViewController.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation
import UIKit

final class MatchesListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let viewModel = MatchesListViewModel(repository: MatchesListRepository())
        viewModel.fetch()
    }
}

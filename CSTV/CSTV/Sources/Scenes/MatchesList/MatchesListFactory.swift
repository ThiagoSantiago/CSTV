//
//  MatchesListFactory.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation
import UIKit

enum MatchesListFactory {
    static func make() -> UIViewController {
        let repository = MatchesListRepository()
        let viewModel = MatchesListViewModel(repository: repository)
       return MatchesListViewController(viewModel: viewModel)
    }
}

//
//  MatchDetailsFactory.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 23/11/22.
//

import Foundation
import UIKit

enum MatchDetailsFactory {
    static func make(matchData: MatchDetailsData) -> UIViewController {
        let repository = MatchDetailsRepository()
        let viewModel = MatchDetailsViewModel(repository: repository, matchData: matchData)
       return MatchDetailsViewController(viewModel: viewModel)
    }
}

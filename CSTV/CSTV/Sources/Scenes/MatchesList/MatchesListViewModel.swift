//
//  MatchesListViewModel.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

protocol MatchesListViewModeling {
    var isLoading: Bindable<Bool> { get }
    var errorMessage: Bindable<String?> { get }
    var matches: Bindable<[Match]> { get }
    func fetch()
}

struct MatchesListViewModel: MatchesListViewModeling {
    var isLoading: Bindable<Bool> = .init(false)
    var errorMessage: Bindable<String?> = .init(nil)
    var matches: Bindable<[Match]> = .init([])
    var repository: MatchesListRepositoryType
    
    func fetch() {
        isLoading.value = true
        
        repository.fetchMatchesList(pageIndex: 1) { result in
            self.isLoading.value = false
            
            switch result {
            case let .success(matchesList):
                self.matches.value = matchesList
            case let .failure(error):
                errorMessage.value = error.localizedDescription
            }
        }
    }
}

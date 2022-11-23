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
    var matches: Bindable<[MatchData]> { get }
    func fetch()
}

final class MatchesListViewModel: MatchesListViewModeling {

    var isLoading: Bindable<Bool> = .init(false)
    var errorMessage: Bindable<String?> = .init(nil)
    var matches: Bindable<[MatchData]> = .init([])
    var repository: MatchesListRepositoryType
    
    private var currentPage = 0
    
    init(repository: MatchesListRepositoryType) {
        self.repository = repository
    }
    
    func fetch() {
        isLoading.value = true
        self.currentPage += 1
        repository.fetchMatchesList(pageIndex: 1) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case let .success(matchesList):
                self.matches.value = matchesList
            case let .failure(error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}

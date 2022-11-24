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
    func fetchNextPage()
    func isNextPageAvailable() -> Bool
}

final class MatchesListViewModel: MatchesListViewModeling {

    var isLoading: Bindable<Bool> = .init(false)
    var errorMessage: Bindable<String?> = .init(nil)
    var matches: Bindable<[MatchData]> = .init([])
    var repository: MatchesListRepositoryType
    
    private var currentPage = 1
    private var nextPageAvailable = true
    
    init(repository: MatchesListRepositoryType) {
        self.repository = repository
    }
    
    func fetch() {
        isLoading.value = true
        makeRequest()
    }
    
    func fetchNextPage() {
        currentPage += 1
        makeRequest()
    }
    
    func isNextPageAvailable() -> Bool {
        nextPageAvailable
    }
    
    private func makeRequest() {
        repository.fetchMatchesList(pageIndex: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case let .success(matchesList):
                if matchesList.count != self.matches.value.count {
                    self.matches.value = matchesList
                } else {
                    self.nextPageAvailable = false
                }
            case let .failure(error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}

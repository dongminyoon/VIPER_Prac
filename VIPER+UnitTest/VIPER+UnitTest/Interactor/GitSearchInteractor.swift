//
//  GitSearchResultInteractor.swift
//  VIPER+UnitTest
//
//  Created by USER on 2021/02/10.
//

import Foundation

protocol GitSearchInteractorProtool {
    func fetchUserRepos(from userName: String)
}

class GitSearchInteractor: GitSearchInteractorProtool {
    private let searchService: GithubSearchServiceProtocol
    
    weak var presenter: GitSearchPresenterProtocol?
    
    init(searchService: GithubSearchServiceProtocol = GithubSearchService()) {
        self.searchService = searchService
    }
    
    func fetchUserRepos(from userName: String) {
        searchService.fetchUserRepos(from: userName, onSuccess: { [weak self] repos in
            self?.presenter?.successFetchUserRepos(repos)
        }, onFailure: { [weak self] error in
            self?.presenter?.failureFetchUserRepos(with: error)
        })
    }
}

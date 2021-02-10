//
//  GithubSearchService.swift
//  VIPER+UnitTest
//
//  Created by USER on 2021/02/10.
//

import Foundation
import Moya

protocol GithubSearchServiceProtocol {
    func fetchUserRepos(from userName: String,
                        onSuccess: @escaping ([GitRepository]) -> Void,
                        onFailure: @escaping (NSError) -> Void)
}

class GithubSearchService: GithubSearchServiceProtocol {
    private let provider: MoyaProvider<Github>
    
    init(provider: MoyaProvider<Github> = MoyaProvider<Github>()) {
        self.provider = provider
    }
    
    /* 유저가 만든 Repository 전부를 가져온다. */
    func fetchUserRepos(from userName: String,
                        onSuccess: @escaping (([GitRepository]) -> Void) = { _ in },
                        onFailure: @escaping ((NSError) -> Void) = { _ in }) {
        let requestType = Github.usersRepo(name: userName)
        
        provider.request(requestType) { result in
            switch result {
            case .success(let response):
                guard let repos = try? JSONDecoder().decode([GitRepository].self, from: response.data) else {
                    onFailure(NSError(domain: "Not Exist", code: -1, userInfo: nil))
                    return
                }
                onSuccess(repos)
            case .failure(let error):
                onFailure(error as NSError)
            }
        }
    }
}

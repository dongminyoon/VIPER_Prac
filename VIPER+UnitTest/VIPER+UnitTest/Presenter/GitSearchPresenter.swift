//
//  GitSearchPresenter.swift
//  VIPER+UnitTest
//
//  Created by USER on 2021/02/10.
//

import Foundation

protocol GitSearchPresenterProtocol: class {
    var interactor: GitSearchInteractorProtool { get }
    var router: GitSearchRouterProtocol { get }
    
    func fetchUserRepos(from userName: String)
    func successFetchUserRepos(_ repos: [GitRepository])
    func failureFetchUserRepos(with error: NSError)
}

class GitSearchPresenter: GitSearchPresenterProtocol {
    var interactor: GitSearchInteractorProtool
    var router: GitSearchRouterProtocol
    
    weak var gitSearchView: GitSearchViewProtocol?
    
    init(interactor: GitSearchInteractorProtool,
         router: GitSearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    /* Interactor로부터 Repository의 정보를 Fetch */
    func fetchUserRepos(from userName: String) {
        interactor.fetchUserRepos(from: userName)
    }
    
    /* Intercator로부터 Repository 정보를 성공적으로 가져온 경우 */
    func successFetchUserRepos(_ repos: [GitRepository]) {
        gitSearchView?.showReposOfFetchResult(repos)
        gitSearchView?.hideLoading()
    }
    
    /* Interactor로부터 알수없는 에러로 인해 정보를 성공적으로 가져오지 못한 경우 */
    func failureFetchUserRepos(with error: NSError) {
        router.presentFailAlertView(by: error)
        gitSearchView?.hideLoading()
    }
}

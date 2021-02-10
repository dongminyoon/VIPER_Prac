//
//  GitSearchPresenterTests.swift
//  VIPER+UnitTestTests
//
//  Created by USER on 2021/02/10.
//

import XCTest
@testable import VIPER_UnitTest

class GitSearchInteractorMock: GitSearchInteractorProtool {
    weak var presenter: GitSearchPresenterProtocol?
    
    var repoFetchParameter: (String)?
    
    func fetchUserRepos(from userName: String) {
        self.repoFetchParameter = userName
    }
}

class GitSearchViewMock: GitSearchViewProtocol {
    var presenter: GitSearchPresenterProtocol!
    
    var isLoading: Bool?
    var repos: [GitRepository]?
    
    func showLoading() {
        isLoading = true
    }
    
    func hideLoading() {
        isLoading = false
    }
    
    func showReposOfFetchResult(_ result: [GitRepository]) {
        self.repos = result
    }
}

class GitSearchRouterMock: GitSearchRouterProtocol {
    var presentingViewController: UIViewController?
    
    var isFail: Bool?
    
    static func createGitSearchModule() -> UIViewController {
        return UIViewController()
    }
    
    func presentFailAlertView(by error: NSError) {
        self.isFail = true
    }
}

class GitSearchPresenterTests: XCTestCase {
    var presenter: GitSearchPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let interactor = GitSearchInteractorMock()
        let router = GitSearchRouter(presentingViewController: UIViewController())
        self.presenter = GitSearchPresenter(interactor: interactor,
                                            router: router)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FetchUserRepos() {
        // given
        let userName = "dongmin"
        guard let interactor = self.presenter.interactor as? GitSearchInteractorMock else {
            XCTFail("Interactor wasn't casting")
            return
        }
        
        // when
        presenter.fetchUserRepos(from: userName)
        
        // then
        XCTAssertEqual(interactor.repoFetchParameter, userName, "UserName was not send to Interactor")
    }
    
    func test_SuccessFetchUserRepos() {
        // given
        let view = GitSearchViewMock()
        self.presenter.gitSearchView = view
        
        let testRepos: [GitRepository] = [
            GitRepository(full_name: "Hi"),
            GitRepository(full_name: "Bye"),
            GitRepository(full_name: "dongmin"),
            GitRepository(full_name: "Hello")
        ]
        
        // when
        self.presenter.successFetchUserRepos(testRepos)
        
        // then
        XCTAssertEqual(testRepos, view.repos, "Repos Search result wasn't send to View")
        XCTAssertEqual(false, view.isLoading, "Loading wasn't finish")
    }
    
    func test_FailureFetchUserRepos() {
        let routerMock = GitSearchRouterMock()
        self.presenter.router = routerMock
        
        self.presenter.failureFetchUserRepos(with: NSError(domain: "", code: -1, userInfo: nil))
        
        XCTAssertEqual(true, routerMock.isFail, "Fail Event was not send")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

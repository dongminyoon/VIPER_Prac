//
//  GitSearchInteractorTests.swift
//  VIPER+UnitTestTests
//
//  Created by USER on 2021/02/10.
//

import XCTest
import UIKit
@testable import VIPER_UnitTest

class GitSearchServiceSuccessMock: GithubSearchServiceProtocol {
    var networkMaterial: String?
    
    func fetchUserRepos(from userName: String,
                        onSuccess: @escaping ([GitRepository]) -> Void,
                        onFailure: @escaping (NSError) -> Void) {
        self.networkMaterial = userName
        
        onSuccess([])
    }
}

class GitSearchServiceFailureMock: GithubSearchServiceProtocol {
    var networkMaterial: String?
    
    func fetchUserRepos(from userName: String,
                        onSuccess: @escaping ([GitRepository]) -> Void,
                        onFailure: @escaping (NSError) -> Void) {
        self.networkMaterial = userName
        onFailure(NSError(domain: "", code: -1, userInfo: nil))
    }
}

// FIXME: - Interactor Unit Test 다시 필요
class GitSearchPresenterMock: GitSearchPresenterProtocol {
    var isSuccess: Bool?
    
    var interactor: GitSearchInteractorProtool
    var router: GitSearchRouterProtocol
    
    init(interactor: GitSearchInteractorProtool,
         router: GitSearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchUserRepos(from userName: String) {
        interactor.fetchUserRepos(from: userName)
    }
    
    func successFetchUserRepos(_ repos: [GitRepository]) {
        self.isSuccess = true
    }
    
    func failureFetchUserRepos(with error: NSError) {
        self.isSuccess = false
    }
}

class GitSearchInteractorTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SuccessFetchUserRepos() {
        // given
        let gitSearchServiceMock = GitSearchServiceSuccessMock()
        let interactor = GitSearchInteractor(searchService: gitSearchServiceMock)
        let gitSearchPresenter = GitSearchPresenterMock(interactor: interactor,
                                                        router: GitSearchRouter(presentingViewController: UIViewController()))
        
        interactor.presenter = gitSearchPresenter
        
        let userName = "dongmin"
        
        // when
        interactor.fetchUserRepos(from: userName)
        
        // then
        XCTAssertEqual(gitSearchPresenter.isSuccess, true, "Fetch User Repo was Failed")
        XCTAssertEqual(gitSearchServiceMock.networkMaterial, userName, "User name wasn't send to service object")
    }
    
    func test_FailureFetchUserRepos() {
        // given
        let gitSearchServiceMock = GitSearchServiceFailureMock()
        let intercator = GitSearchInteractor(searchService: gitSearchServiceMock)
        let gitSearchPresenter = GitSearchPresenterMock(interactor: intercator,
                                                        router: GitSearchRouter(presentingViewController: UIViewController()))
        
        intercator.presenter = gitSearchPresenter
        
        let userName = "dongmin"
        
        // when
        intercator.fetchUserRepos(from: userName)
        
        // then
        XCTAssertEqual(gitSearchPresenter.isSuccess, false, "Fetch User Repo was Success")
        XCTAssertEqual(gitSearchServiceMock.networkMaterial, userName, "User name wasn't send to service object")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

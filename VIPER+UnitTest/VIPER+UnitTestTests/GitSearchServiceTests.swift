//
//  GithubSearchServiceTests.swift
//  VIPER+UnitTestTests
//
//  Created by USER on 2021/02/10.
//

import XCTest
@testable import VIPER_UnitTest
@testable import Moya

fileprivate final class ProviderMock: MoyaProvider<Github> {
    var requestMaterial: (url: URL,
                          method: Moya.Method,
                          header: [String: String]?,
                          body: [String: String]?,
                          task: Task)?
    
    override func request(_ target: Github, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping Completion) -> Cancellable {
        var body: [String: String]?
        
        switch target.task {
        case .requestPlain: body = nil
        case .requestParameters(let parameters, _):
            body = parameters as? [String: String]
        default: body = nil
        }
        
        let full_url = target.baseURL.appendingPathComponent(target.path)
        self.requestMaterial = (
            url: full_url,
            method: target.method,
            header: target.headers,
            body: body,
            task: target.task
        )
        
        return SimpleCancellable()
    }
}

class GitSearchServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_requestUserRepos() {
        // given
        let providerMock = ProviderMock()
        let githubSearchService = GithubSearchService(provider: providerMock)
        let userName = "dongmin"
        
        let correctURL = "https://api.github.com/users/\(userName.escapingUrl)/repos"
        let correctMethod = Moya.Method.get
        let correctHeader = ["Content-Type": "application/json"]
        let correctBody: [String: String]? = nil
        
        // when
        githubSearchService.fetchUserRepos(from: userName)
        guard let requestMaterial = providerMock.requestMaterial else { return }
        
        // then
        XCTAssertEqual(correctURL, requestMaterial.url.absoluteString, "URL was wrong")
        XCTAssertEqual(correctMethod, requestMaterial.method, "Method was wrong")
        XCTAssertEqual(correctHeader, requestMaterial.header, "Header was wrong")
        XCTAssertEqual(correctBody, requestMaterial.body, "Body Parameter was wrong")
        
        if case .requestPlain = requestMaterial.task {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

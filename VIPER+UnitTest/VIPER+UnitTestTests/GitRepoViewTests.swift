//
//  GitRepoViewTests.swift
//  VIPER+UnitTestTests
//
//  Created by USER on 2021/02/10.
//

import XCTest
@testable import VIPER_UnitTest

class GitRepoViewTests: XCTestCase {
    var repoController: ViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let rootVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController,
              let repoController = rootVC.topViewController as? ViewController else { return }
        self.repoController = repoController
        self.repoController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_showReposOfFetchResult() {
        // given
        var testRepos: [GitRepository] = []
        
        for _ in 0...10 {
            let repo = GitRepository(full_name: "Hi")
            testRepos.append(repo)
            
            // when
            self.repoController.showReposOfFetchResult(testRepos)
            
            // then
            XCTAssertEqual(self.repoController.resultTableView.numberOfRows(inSection: 0), testRepos.count, "Data was not send")
        }
    }
    
    func test_showLoading() {
        // when
        self.repoController.showLoading()
        
        // then
        XCTAssertEqual(self.repoController.activityView.isHidden, false, "Not working showLoading")
        XCTAssertEqual(self.repoController.activityView.isAnimating, true, "Not working showLoading")
    }
    
    func test_hideLoading() {
        // when
        self.repoController.hideLoading()
        
        // then
        XCTAssertEqual(self.repoController.activityView.isHidden, true, "Not working hideLoading")
        XCTAssertEqual(self.repoController.activityView.isAnimating, false, "Not working hideLoading")
    }
    
    func test_TableViewIdentifier() {
        let identifier = String(describing: GitRepositoryCell.self)
        
        self.repoController.resultTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(identifier, "GitRepositoryCell", "Identifier was wrong")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

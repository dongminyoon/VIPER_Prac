//
//  GitSearchRouter.swift
//  VIPER+UnitTest
//
//  Created by USER on 2021/02/10.
//

import UIKit

protocol GitSearchRouterProtocol {
    var presentingViewController: UIViewController? { get set }
    
    static func createGitSearchModule() -> UIViewController
    func presentFailAlertView(by error: NSError)
}

class GitSearchRouter: GitSearchRouterProtocol {
    weak var presentingViewController: UIViewController?
    
    init(presentingViewController: UIViewController?) {
        self.presentingViewController = presentingViewController
    }
    
    @discardableResult
    static func createGitSearchModule() -> UIViewController {
        guard let rootNavi = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController as? UINavigationController,
              let presentingViewController = rootNavi.topViewController as? ViewController else { return UIViewController() }
        
        let gitSearchService = GithubSearchService()
        let gitSearchInteractor = GitSearchInteractor(searchService: gitSearchService)
        let gitSearchRouter = GitSearchRouter(presentingViewController: presentingViewController)
        let gitSearchPresenter = GitSearchPresenter(interactor: gitSearchInteractor,
                                                    router: gitSearchRouter)
        gitSearchPresenter.gitSearchView = presentingViewController
        gitSearchInteractor.presenter = gitSearchPresenter
        
        presentingViewController.presenter = gitSearchPresenter
        return presentingViewController
    }
    
    func presentFailAlertView(by error: NSError) {
        let alertViewController = UIAlertController(title: "Fetch Fail", message: error.domain, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertViewController.addAction(alertAction)
        self.presentingViewController?.present(alertViewController, animated: true, completion: nil)
    }
}

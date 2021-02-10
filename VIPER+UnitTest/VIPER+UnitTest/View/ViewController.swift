//
//  ViewController.swift
//  VIPER+UnitTest
//
//  Created by USER on 2021/02/10.
//

import UIKit
import RxCocoa
import RxSwift

protocol GitSearchViewProtocol: class {
    func showLoading()
    func hideLoading()
    
    func showReposOfFetchResult(_ result: [GitRepository])
}

class ViewController: UIViewController, GitSearchViewProtocol {
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView! {
        didSet {
            self.activityView.isHidden = true
            self.activityView.stopAnimating()
        }
    }
    
    var presenter: GitSearchPresenterProtocol!
    
    var gitRepositoryModels: [GitRepository] = []
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initSearchBar()
        setTableView()
        bindSearchBar()
        GitSearchRouter.createGitSearchModule()
    }

    private func initSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.title = "Github Search"
    }
    
    private func setTableView() {
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
    private func bindSearchBar() {
        self.navigationItem.searchController?.searchBar.rx.text
            .orEmpty
            .filter { $0 != "" }
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                self?.showLoading()
                self?.presenter.fetchUserRepos(from: text)
            })
            .disposed(by: disposeBag)
    }
    
    func showLoading() {
        self.activityView.startAnimating()
        self.activityView.isHidden = false
    }
    
    func hideLoading() {
        self.activityView.stopAnimating()
        self.activityView.isHidden = true
    }
    
    func showReposOfFetchResult(_ result: [GitRepository]) {
        self.gitRepositoryModels = result
        self.resultTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: GitRepositoryCell.self)
        
        guard let gitRepoCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? GitRepositoryCell else { return UITableViewCell() }
        gitRepoCell.nameLabel.text = self.gitRepositoryModels[indexPath.row].full_name
        
        return gitRepoCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gitRepositoryModels.count
    }
}

extension ViewController: UITableViewDelegate {
    
}

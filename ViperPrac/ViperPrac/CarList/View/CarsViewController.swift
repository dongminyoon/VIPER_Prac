//
//  CarsViewController.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import UIKit

class CarsViewController: UIViewController {
    static let identifier = "CarsViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CarsPresenterProtocol!
    var viewModels: [CarDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CarsRouter.createCarsListModule()
        setTableView()
        showCars()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadCars), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func reloadCars() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.tableView.refreshControl?.endRefreshing()
        })
    }
    
    private func showCars() {
        presenter.showCars { viewModels in
            self.viewModels = viewModels
            self.tableView.reloadData()
        }
    }
}

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell \(indexPath)")
        guard let carCell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier) as? CarCell else { return UITableViewCell() }
        carCell.configure(from: viewModels[indexPath.row])
        return carCell
    }
}

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCarDetail(for: viewModels[indexPath.row])
    }
}

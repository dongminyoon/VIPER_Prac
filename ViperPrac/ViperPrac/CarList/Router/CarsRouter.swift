//
//  CarsRouter.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import UIKit

/*
 Router Protocol
 : 어떤 화면이 어떤 화면으로 넘어가는지 로직을 가진 Router Protocol
 : Router의 형상만 가지고 있는 Protocol, 실제 구현을 다루지는 않는다.
 */
protocol CarsRouterProtocol {
    static func createCarsListModule() -> UIViewController
    func showCarDetail(for viewModel: CarViewModel)
    func showCreateCarScreen()
}

/*
 Router Object
 : 어떤 화면에서 어떤 화면으로 넘어갈지 로직을 다루고 있는 Router Object
 */
class CarsRouter: CarsRouterProtocol {
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    @discardableResult
    static func createCarsListModule() -> UIViewController {
        guard let rootNavi = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController as? UINavigationController,
              let carsListVC = rootNavi.topViewController as? CarsViewController else { return UIViewController() }
        
        let carsAPIService: CarsAPIServiceProtocol = CarsAPIService()
        let carsInteractor: CarsInteractorProtocol = CarsInteractor(apiService: carsAPIService)
        let carsRouter: CarsRouterProtocol = CarsRouter(presentingViewController: carsListVC)
        let carsPresenter: CarsPresenterProtocol = CarsPresenter(interactor: carsInteractor,
                                                                 router: carsRouter)
        
        carsListVC.presenter = carsPresenter
        return carsListVC
    }
    
    /*
     - 현재 뷰로부터 다음 Detial 뷰를 띄우기 위한 로직이 필요한 Method
     - 보통 UIViewController들을 다루고 Data를 바인딩
     */
    func showCarDetail(for viewModel: CarViewModel) {
        guard let navigationController = presentingViewController.navigationController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carDetailViewController = storyboard.instantiateViewController(withIdentifier: "CarDetailViewController")
//        carDetailViewController.viewModel = viewModel
        
        navigationController.pushViewController(carDetailViewController, animated: true)
    }
    
    /*
     - 새로운 차를 생성하기 위한 뷰를 띄우기 위한 로직을 가지는 Method
     */
    func showCreateCarScreen() {
        guard let navigationController = presentingViewController.navigationController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carDetailViewController = storyboard.instantiateViewController(withIdentifier: "CreateCarViewController")
        
        navigationController.pushViewController(carDetailViewController, animated: true)
    }
    
}

//
//  CarsPresenter.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

/*
 Presenter Protocol
 : Cars의 정보를 Interactor로부터 Fetch해오고 View에게 해당 Entity를 넘겨주는 Protocol
 : 실제 객체를 담고있지는 않고 의존성을 줄이기 위해 추상화 Protocol
 */
protocol CarsPresenterProtocol {
    func showCars(_ completion: (_ cars: [CarDTO]) -> Void)
    func showCarDetail(for viewModel: CarDTO)
    func showCreateCarScreen()
}

/*
 Presenter의 실제 Object
 : Presenter 역할을 하는 실제 객체
 : Interactor와 View 사이에서 뷰를 보여주기 위한 로직들을 수행하는 UIKit과는 의존성이 없지만 뷰를 보여주는 비즈니스 로직을 가진 객체
 */
class CarsPresenter: CarsPresenterProtocol {
    let interactor: CarsInteractorProtocol
    let router: CarsRouterProtocol
    
    init(interactor: CarsInteractorProtocol,
         router: CarsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // View에서 요청 후, Interactor를 통해 Fetch 후, 화면에 보여주는 메소드
    func showCars(_ completion: ([CarDTO]) -> Void) {
        interactor.fetchCars { cars in
            guard let cars = cars else {
                completion([])
                return
            }
            
            let carsDTO = createCarsViewModels(from: cars)
            completion(carsDTO)
        }
    }
    
    func showCarDetail(for viewModel: CarDTO) {
        router.showCarDetail(for: viewModel)
    }
    
    func showCreateCarScreen() {
        router.showCreateCarScreen()
    }
    
    // Interactor 객체로부터 Entity를 View에 띄우기 위해 가공하는 로직
    // 이 DTO나 뷰에 보일 데이터로 가공하는 로직이 Interactor에서 JSON Deconding을 진행하고 여기서는 뷰에 보이는 형식으로 가공
    private func createCarsViewModels(from cars: [Car]) -> [CarDTO] {
        return cars.map { car in
            return CarDTO(make: car.make,
                                model: car.model)
        }
    }
}

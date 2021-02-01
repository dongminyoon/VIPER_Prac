//
//  CarsInteractor.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

/*
 Interactor Protocol
 : Cars의 Entity를 가져오는 비즈니스 로직을 가지고 있는 Object
 : 보통 API 콜 또는 가져온 Entity의 데이터를 가공해서 Presenter로 전달하는 역할을 한다.
 : 의존성을 분리하기 위해 분리하여 구현체는 없고 형상만 가지고 있는 프로토콜
 */
protocol CarsInteractorProtocol {
    func fetchCars(_ completion: ([Car]?) -> Void)
}

/*
 Interactor의 실제 Object
 : Presenter에서는 이 Object를 사용해서 필요한 데이터를 Fetch해오고 데이터를 가공
 :
 */
class CarsInteractor: CarsInteractorProtocol {
    let apiService: CarsAPIServiceProtocol
    
    init(apiService: CarsAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchCars(_ completion: ([Car]?) -> Void) {
        apiService.requestCars { cars, error in
            guard let cars = cars else {
                completion([])
                return
            }
            
            completion(cars)
        }
    }
}

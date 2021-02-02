//
//  CarDetailInteractor.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation


/*
 Interactor Protocol
 : Cars Detail의 Entitiy를 가져오는 비즈니스 로직을 가지고 있는 Object
 : API 콜을 이용해서 Entity의 데이터를 가공해서 Presenter로 전달하는 역할을 한다.
 : 의존성의 띄지 않기 위해 구현체는 가지고 있지 않고 형상만 가진 프로토콜
 */
protocol CarDetailInteractorProtocol {
    func fetchDetailCar(from id: String, _ completion: (Car?) -> Void)
}

/*
 Interactor의 실제 Object
 : Presenter에서 이 Object를 사용해서 필요한 데이터를 Fetch해오고 데이터를 가공
 */
class CarDetailInteractor: CarDetailInteractorProtocol {
    let apiService: CarDetailAPIServiceProtocol
    
    init(apiService: CarDetailAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchDetailCar(from id: String, _ completion: (Car?) -> Void) {
        apiService.requestCarDetail(from: id) { detailCar, error in
            guard let detailCar = detailCar else {
                completion(nil)
                return
            }
            
            completion(detailCar)
        }
    }
}

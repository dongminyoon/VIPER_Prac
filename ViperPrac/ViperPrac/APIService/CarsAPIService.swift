//
//  CarsAPIService.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

/*
 APIService Protocol
 : 나중에 Unit Test를 실행할 때, Protocl을 만듬으로 의존성을 줄여 Mock 객체를 생성함으로 테스트가 가능하게 Protocol
 */
protocol CarsAPIServiceProtocol {
    func requestCars(completion: ([Car]?, NSError?) -> Void)
}

/*
 APIService
 : 외부 모듈에 의존해서 Networking을 요청하는 Object
 */
class CarsAPIService: CarsAPIServiceProtocol {
    func requestCars(completion: ([Car]?, NSError?) -> Void) {
        let carsItem: [Car] = [
            Car(id: "1", make: "현대", model: "Avante", trim: "222"),
            Car(id: "2", make: "기아", model: "K5", trim: "333"),
            Car(id: "3", make: "BMW", model: "520d", trim: "4444"),
            Car(id: "4", make: "Mercedes-Benz", model: "C class", trim: "5555"),
            Car(id: "5", make: "기아", model: "K3", trim: "6666")
        ]
        
        completion(carsItem, nil)
    }
}

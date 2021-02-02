//
//  CarDetailAPIService.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

/*
 APIService Protocol
 : Detail 정보에 관한 API를 호출하는 Protocol
 : 형체만 갖추고 있고 더 자세한 구현 사항은 채택하는 Object에서 구현하게 된다.
 : + 생각에 Cars 정보를 요청하는 객체는 Moya 등의 API를 이용해서 하나로 묶는게 더 좋을 듯
 */
protocol CarDetailAPIServiceProtocol {
    func requestCarDetail(from id: String, completion: (Car?, NSError?) -> Void)
}

/*
 APIService
 : 외부 모듈을 사용할 경우 의존해서 Networking을 요청하는 Object
 */
class CarDetailAPIService: CarDetailAPIServiceProtocol {
    func requestCarDetail(from id: String, completion: (Car?, NSError?) -> Void) {
        let carsItem: [Car] = [
            Car(id: "1", make: "현대", model: "Avante", trim: "222"),
            Car(id: "2", make: "기아", model: "K5", trim: "333"),
            Car(id: "3", make: "BMW", model: "520d", trim: "4444"),
            Car(id: "4", make: "Mercedes-Benz", model: "C class", trim: "5555"),
            Car(id: "5", make: "기아", model: "K3", trim: "6666")
        ]
        
        guard let detail = carsItem.filter({ $0.id == id }).first else {
            completion(nil, NSError(domain: "Not Exist Car", code: -1, userInfo: nil))
            return
        }
        
        completion(detail, nil)
    }
}

//
//  CarDetailAPIService.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

protocol CarDetailAPIServiceProtocol {
    func requestCarDetail(completion: (Car?, NSError?) -> Void)
}

class CarDetailAPIService: CarDetailAPIServiceProtocol {
    func requestCarDetail(completion: (Car?, NSError?) -> Void) {
        let car
    }
}

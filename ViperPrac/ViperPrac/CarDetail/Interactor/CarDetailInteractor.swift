//
//  CarDetailInteractor.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

protocol CarDetailInteractorProtocol {
    func fetchDetailCar(_ completion: (Car?) -> Void)
}

class CarDetailInteractor: CarDetailInteractorProtocol {
    let apiService: CarDetailAPIServiceProtocol
    
    init(apiService: CarDetailAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchDetailCar(_ completion: (Car?) -> Void) {
        <#code#>
    }
}

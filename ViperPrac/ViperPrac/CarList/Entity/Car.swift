//
//  Car.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

/*
Entity
: API 콜로부터 받을 수 있는 Object
*/
struct Car {
    let id: String
    let make: String
    let model: String
    let trim: String
    
    func makeCarDTO() -> CarDTO {
        return CarDTO(make: self.make,
                      model: self.model)
    }
}

/*
DTO
: API 콜로부터 불러온 Entity를 화면에 보여주기 위한 Model
: 보통 Presenter로부터 생성되어 View로 전달
*/
struct CarDTO {
    let make: String
    let model: String
}

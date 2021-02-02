//
//  CarDetail\.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import Foundation

struct CarDetail {
    let id: String
    let make: String
    let model: String
    let trim: String
    
    func makeDetailDTO() -> CarDetailDTO {
        return CarDetailDTO(make: self.make,
                            model: self.model)
    }
}

struct CarDetailDTO {
    let make: String
    let model: String

}

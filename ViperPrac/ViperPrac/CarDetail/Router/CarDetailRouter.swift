//
//  CarDetailRouter.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import UIKit

protocol CarDetailRouterProtocol {
    static func createCarDetailModule() -> UIViewController
}

class CarDetailRouter: CarDetailRouterProtocol {
    static func createCarDetailModule() -> UIViewController {
        
        return UIViewController()
    }
    
}

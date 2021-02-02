//
//  CarDetailViewController.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import UIKit

class CarDetailViewController: UIViewController {
    static let identifier = "CarDetailViewController"
    
    var carDetailDTO: CarDTO?

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeLabel.text = carDetailDTO?.make
        modelLabel.text = carDetailDTO?.model
    }
}

//
//  CarCell.swift
//  ViperPrac
//
//  Created by USER on 2021/02/01.
//

import UIKit

class CarCell: UITableViewCell {
    static let identifier = "CarCell"
    
    @IBOutlet weak var makeName: UILabel!
    @IBOutlet weak var modelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(from carModel: CarDTO) {
        makeName.text = carModel.make
        modelName.text = carModel.model
    }
}

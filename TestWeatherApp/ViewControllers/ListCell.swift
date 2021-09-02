//
//  ListCell.swift
//  TestWeatherApp
//
//  Created by Ilya Yushkov on 01.09.2021.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var conditionCityLabel: UILabel!
    @IBOutlet var temperatureCityLabel: UILabel!
    
    func configure(weather: Weather) {
        
        self.nameCityLabel.text = weather.name
        self.conditionCityLabel.text = weather.conditionString
        self.temperatureCityLabel.text = weather.temperatureString
    }
}

//
//  MoreDetailsViewController.swift
//  TestWeatherApp
//
//  Created by Ilya Yushkov on 01.09.2021.
//

import UIKit
import SwiftSVG

class MoreDetailsViewController: UIViewController {

    @IBOutlet var nameCityLabel: UILabel!
    
    @IBOutlet var viewLabel: UIView!
    
    @IBOutlet var conditionLabel: UILabel!
    
    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet var pressureLabel: UILabel!
    
    @IBOutlet var windSpeedLabel: UILabel!
    
    @IBOutlet var minTemperatureLabel: UILabel!
    
    @IBOutlet var maxTemperatureLabel: UILabel!
    
    var weatherModel: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLabel()
    }
    
    private func refreshLabel() {
        
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel.conditionCode).svg") else { return }
        
        let weatherImage = UIView(SVGURL: url) { image in
            image.resizeToFit(self.viewLabel.bounds)
        }
        
        self.viewLabel.addSubview(weatherImage)
        
        nameCityLabel.text = weatherModel.name
        temperatureLabel.text = weatherModel.temperatureString
        pressureLabel.text = "\(weatherModel.pressureMm)"
        windSpeedLabel.text = "\(weatherModel.windSpeed)"
        minTemperatureLabel.text = "\(weatherModel.tempMin)"
        maxTemperatureLabel.text = "\(weatherModel.tempMax)"
    }

}

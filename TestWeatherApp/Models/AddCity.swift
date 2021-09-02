//
//  AddCity.swift
//  TestWeatherApp
//
//  Created by Ilya Yushkov on 01.09.2021.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { action in
            
            let textFieldText = alertController.textFields?.first
            guard let text = textFieldText?.text else { return }
            
            completionHandler(text)
        }
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        let alertActionCancel = UIAlertAction(title: "Отмена", style: .default)
        
        alertController.addAction(alertActionOk)
        alertController.addAction(alertActionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}

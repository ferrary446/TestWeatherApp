//
//  MainViewController.swift
//  TestWeatherApp
//
//  Created by Ilya Yushkov on 01.09.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let emptyCities = Weather()
    private var citiesArray = [Weather]()
    private var filterCityArray = [Weather]()
    
    private var nameOfCities = ["Москва", "Санкт-Петербург", "Екатеринбург", "Новосибирск", "Краснодар", "Хабаровск", "Владивосток", "Казань", "Нижний Новгород", "Уфа"]
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCities, count: nameOfCities.count)
        }
        
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        
        alertPlusCity(name: "Город", placeholder: "Введите название города") { city in
            self.nameOfCities.append(city)
            self.citiesArray.append(self.emptyCities)
            self.addCities()
        }
        
    }
    
    
    private func addCities() {
        
        getCityWeather(citiesArray: self.nameOfCities) { (index, weather) in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameOfCities[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filterCityArray.count
        }
        return citiesArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! ListCell
        
        var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        
        cell.configure(weather: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler in
            
            let editingRow = self.nameOfCities[indexPath.row]
            
            if let index = self.nameOfCities.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                
                let filter = filterCityArray[indexPath.row]
                let detailVC = segue.destination as! MoreDetailsViewController
                detailVC.weatherModel = filter
                
            } else {
                
                let cityWeather = citiesArray[indexPath.row]
                let detailVC = segue.destination as! MoreDetailsViewController
                detailVC.weatherModel = cityWeather
                
            }
            
        }
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}

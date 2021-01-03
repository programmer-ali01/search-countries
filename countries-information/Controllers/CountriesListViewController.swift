//
//  ViewController.swift
//  countries-information
//
//  Created by Alisena Mudaber on 12/29/20.
//

import UIKit

class CountryListViewController: UIViewController, UISearchBarDelegate {
    
    var countriesList = [Results]()
    let tableView = UITableView()
    let cellId = "cellId"
    
    private let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        style()
        layout()
        apiCalling()
        renderSearchBar()

    }
    
    func renderSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.scopeButtonTitles = ["Americas", "Europe", "Asia", "Australia", "Africa"]
        
        
        let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = .black
        searchBarTextField?.placeholder = "Search a country"
        
        
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                Service.shared.fetchCountryData() { [weak self] result  in
                    self?.countriesList = result
                    if searchText.isEmpty == false {
                        self?.countriesList = (self?.countriesList.filter({ $0.name.contains(searchText)}))!
                    } else {
                        self?.countriesList = self!.countriesList
                    }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            })
    }
    
    func tableViewSetup() {
        navigationItem.title = "Search Country Information"
        
        tableView.register(CountryViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        
      
        
    }
    
    func apiCalling() {
        let anonymousFunction = { (fetchedCountryData: [Results]) in
            DispatchQueue.main.async {
                self.countriesList = fetchedCountryData
                self.tableView.reloadData()
            }

        }
        Service.shared.fetchCountryData(onCompletion: anonymousFunction)

    }
    
    
    
    func style() {
        
    }
    
    func layout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let countryFields = countriesList[indexPath.row]
        
        guard let countryCell = cell as? CountryViewCell else {
            return cell
        }
        countryCell.countryNameLabel.text = countryFields.name
        countryCell.capitalLabel.text = countryFields.capital

        return cell
    }
}

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.countriesList[indexPath.row]
        let countryDetailVC = CountryDetailViewController()
        countryDetailVC.country = country
        countryDetailVC.modalPresentationStyle = .fullScreen
        countryDetailVC.modalTransitionStyle = .flipHorizontal
        self.present(countryDetailVC, animated: true)
    }
}




//
//  CountryDetailViewController.swift
//  countries-information
//
//  Created by Alisena Mudaber on 12/29/20.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    var country: Results!
    
    let countryNameLabel = UILabel()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupNameLabel()
        setupDismissButton()
        setupData()
    }
    
    func setupNameLabel() {
        view.addSubview(countryNameLabel)
    
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        countryNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        countryNameLabel.textColor = .white
    }
    
    func setupDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    func setupData() {
        if let country = country {
            countryNameLabel.text = country.name
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}

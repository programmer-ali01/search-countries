//
//  CountryViewCell.swift
//  countries-information
//
//  Created by Alisena Mudaber on 12/29/20.
//

import UIKit

class CountryViewCell: UITableViewCell {
    
    // MARK: - Variables
    let countryNameLabel = UILabel()
    let capitalLabel = UILabel()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupCountryNameLabel()
        setupCapitalLabel()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCountryNameLabel() {
        addSubview(countryNameLabel)
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        countryNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        countryNameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    
    func setupCapitalLabel() {
        addSubview(capitalLabel)
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.leadingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor).isActive = true
        capitalLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor).isActive = true
        
        capitalLabel.font = UIFont(name: "Verdana", size: 14)
    }
    

    
}

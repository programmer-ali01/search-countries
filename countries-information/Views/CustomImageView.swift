//
//  CustomImageView.swift
//  countries-information
//
//  Created by Alisena Mudaber on 12/29/20.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let activitySpinner = UIActivityIndicatorView(style: .medium)
    func renderImage(from url: URL) {
        image = nil
        renderSpinner()
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("couldn't load image from \(url)")
                return
            }
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task.resume()
    }
    
    func renderSpinner() {
        addSubview(activitySpinner)
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false
        activitySpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activitySpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        activitySpinner.startAnimating()
    }
    
    func removeSpinner() {
        activitySpinner.removeFromSuperview()
    }
}

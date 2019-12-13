//
//  Extentions.swift
//  git
//
//  Created by mostfa on 12/9/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import Foundation
import UIKit
/*
 This extention aims to add shadow with rounded corners to views
 
 */
extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

/*
 simple image downloader for UIImageView, Cached by default using NSURLCache(URLCache) 
 */
extension UIImageView {

    func loadImage(urlString: String?) {
        
        self.isSkeletonable = true
        self.showAnimatedSkeleton(usingColor: .midnightBlue, animation: nil, transition: .crossDissolve(0.7))
        guard let url = URL(string: urlString ?? " ") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                self.hideSkeleton()
                self.image = image
            }
        }.resume()

    }
}

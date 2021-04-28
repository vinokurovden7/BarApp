//
//  Beer.swift
//  BarApp
//
//  Created by Денис Винокуров on 27.04.2021.
//

import Foundation
import UIKit

class Beer {
    
    private let imageNameBeer: String
    private let nameBeer: String
    private let priceBeer: Double
    private let countryBeer: String
    private var remainingBeer: Double
    
    func getNameBeer() -> String {
        return nameBeer
    }
    
    func getPrice() -> Double {
        return priceBeer
    }
    
    func getCountry() -> String {
        return countryBeer
    }
    
    func getRemaining() -> Double {
        return remainingBeer
    }
    
    func getImageBeer() -> UIImage {
        return UIImage(named: imageNameBeer) ?? UIImage(systemName: "questionmark.square.dashed")!
    }
    
    func setRemaining(countLiters: Double) {
        remainingBeer -= countLiters
    }
    
    init(imageNameBeer: String, nameBeer: String, priceBeer: Double, countryBeer: String, remainingBeer: Double) {
        self.imageNameBeer = imageNameBeer
        self.nameBeer = nameBeer
        self.priceBeer = priceBeer
        self.countryBeer = countryBeer
        self.remainingBeer = remainingBeer
    }
}

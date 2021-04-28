//
//  BeerManager.swift
//  BarApp
//
//  Created by Денис Винокуров on 28.04.2021.
//

import Foundation

class BeerManager {
    
    static let shared = BeerManager()
    
    var revenueBeer: Double
    
    private init() {
        revenueBeer = 0
    }
}

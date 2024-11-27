//
//  MenuItem.swift
//  Little Lemon
//
//  Created by CoraciasCaudata on 13/11/2024.
//

import Foundation

struct MenuItem: Decodable {
        // , Hashable { // }, Identifiable {
    // var id = UUID()        //  for some reason this stops the rendering of Core Data...
    let title: String
    let image: String
    let price: String
    let descriptionOfDish: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case descriptionOfDish = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}

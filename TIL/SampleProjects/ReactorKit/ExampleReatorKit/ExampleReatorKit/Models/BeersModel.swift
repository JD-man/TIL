//
//  BeersModel.swift
//  ExampleReatorKit
//
//  Created by JD_MacMini on 2022/03/02.
//

import Foundation

struct Beer: Codable {
    var id: Int?
    var name: String?
    var tagline: String?
    var firstBrewed: String?
    var description: String?
    var imageURL: String?
    var abv: Double?
    var ibu: Double?
    var targetFg: Double?
    var targetOg: Double?
    var ebc: Double?
    var srm: Double?
    var ph: Double?
    var attenuationLevel: Double?
    var volume: BeerVolume?
    var boilVolume: BeerVolume?
    var method: BeerMethod?
    var ingredients: BeerIngredient?
    var foodPairing: [String]?
    var brewersTips: String?
    var contributedBy: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description, abv, ibu, ebc, srm, ph, volume, method, ingredients
        case firstBrewed = "first_brewed"
        case imageURL = "image_url"
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case attenuationLevel = "attenuation_level"
        case boilVolume = "boil_volume"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

struct BeerVolume: Codable {
    var value: Double?
    var unit: String?
}

struct BeerMethod: Codable {
    var mashTemp: [BeerMashTemp]?
    var fermentation: BeerTemp?
    var twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

struct BeerMashTemp: Codable {
    var temp: BeerTemp?
    var duration: Double?
}

struct BeerTemp: Codable {
    var value: Double?
    var unit: String?
}

struct BeerIngredient: Codable {
    var malt: [BeerMalt]?
    var hops: [BeerHops]?
    var yeast:  String?
}

struct BeerMalt: Codable {
    var name: String?
    var amount: BeerAmount?
}

struct BeerAmount: Codable {
    var value: Double?
    var unit: String?
}

struct BeerHops: Codable {
    var name: String?
    var amount: BeerAmount?
    var add: String?
    var attribute: String?
}

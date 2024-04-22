//
//  Country.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

struct Country : Codable, Hashable {
    
    let name : String?
    let capital : String?
    let subregion : String?
    let region : String?
    let population : Int?
    let latlng : [Double]?
    let currencies : [Currency]?
    let languages : [Language]?
    let flag : Flag?
    let alpha3Code: String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case capital = "capital"
        case subregion = "subregion"
        case region = "region"
        case population = "population"
        case latlng = "latlng"
        case currencies = "currencies"
        case languages = "languages"
        case flag = "flags"
        case alpha3Code = "alpha3Code"
    }
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

struct Language : Codable {
    let iso639_1 : String?
    let iso639_2 : String?
    let name : String?
    let nativeName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case iso639_1 = "iso639_1"
        case iso639_2 = "iso639_2"
        case name = "name"
        case nativeName = "nativeName"
    }
}

struct Currency : Codable {
    let code : String?
    let name : String?
    let symbol : String?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case name = "name"
        case symbol = "symbol"
    }
}

struct Flag : Codable {
    let png : String?
    
    enum CodingKeys: String, CodingKey {
        case png = "png"
    }
}

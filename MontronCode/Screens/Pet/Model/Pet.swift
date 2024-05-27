//
//  Pet.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import Foundation

// MARK: - Data Model

struct DataModel: Decodable {
    let pets: [PetModel]?
}

// MARK: - Pet Model

struct PetModel: Decodable {
    let imageUrl: String?
    let title: String?
    let contentUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case title
        case contentUrl = "content_url"
    }
}

// MARK: - Response Data Model

struct ResponseData: Codable {
    let settings: Settings
}

 // MARK: - Settings Model

struct Settings: Codable {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
}

//
//  MeteorModel.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation

struct Meteor: Codable {
    var name: String
    var mass: String?
    var latitude: String?
    var longitude: String?
    var year: Date?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case mass = "mass"
        case latitude = "reclat"
        case longitude = "reclong"
        case year = "year"
    }
    
}

extension Meteor {
    var massValue: Double? {
        guard let mass = mass else { return nil }
        return Double(mass)
    }
}


extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}


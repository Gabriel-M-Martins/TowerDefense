//
//  UILabels.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation

enum Label {
    case placeCity
    
    var values: (text: String, key: String) {
        switch self {
        case .placeCity:
            return ("Choose where to place your city.", "Place City")
        }
    }
}

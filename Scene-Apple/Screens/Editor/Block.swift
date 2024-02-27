//
//  Block.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import Foundation

struct Block: Codable {
    
    let id: String
    let text: String
    var children: [Block]
}

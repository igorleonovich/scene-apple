//
//  Block.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import Foundation

struct Block: Codable {
    
    var id = UUID().uuidString
    var text = "Your text"
    var children = [Block]()
    var isCollapsed = true
    var description = ""
    var descriptionState: DescriptionState = .folded
    var blockType: BlockType = .common
}

enum DescriptionState: String, Codable {
    
    case folded // 0 strings are visible
    case semiRevealed // 1 string is visible
    case revealed // all strings are visible
}

enum BlockType: String, Codable {
    
    case rootPoint
    case view
    case automaticSection
    case manualSection
    case groupAsSection
    case sceneMark
    case episodeMark
    case common
}

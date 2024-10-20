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
    var blockType: BlockType = .point
}

enum DescriptionState: String, Codable {
    
    case folded // 0 strings are visible
    case semiRevealed // 1 string is visible
    case revealed // all strings are visible
}

enum BlockType: String, Codable {
    
//    case view
    case automaticSection
    case manualSection
    
// Add it just on UI, not to real structure:
//    case rootPoint
//    case sceneMark
//    case episodeMark
    
    case point
}

// [TODO] Определить структуру данных
// Варианты:
// 1. Писать всё классами, и мапить при необходимости на структуры
// 2. Всё на структурах, смаплено через id

//class Point: NSObject {
//class Point {
//    var id: UUID
//    let text: String
//    
//    init(id: UUID = UUID(), text: String) {
//        self.id = id
//        self.text = text
//    }
//}

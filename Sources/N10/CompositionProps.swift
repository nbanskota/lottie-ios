//
//  File.swift
//  
//
//  Created by Nitesh Bankshota on 7/5/2024.
//

import Foundation
struct CompositionProps: Equatable {
    
    let type: LayerType
    var width: CGFloat?
    var height: CGFloat?
    var offsetX: CGFloat?
    var offsetY: CGFloat?
    var opacity: Double?
    var text: String?
    var fontName: String?
    var fontWeight: Int?
    var scaleFactor: Double?

    
    init(type: LayerType, width: CGFloat? = nil, height: CGFloat? = nil, offsetX: CGFloat? = nil, offsetY: CGFloat? = nil, text: String? = nil, fontName: String? = nil, fontWeight: Int? = nil, scaleFactor: Double? = nil, additionalProperties: [String: Any]? = nil) {
        self.type = type
        self.width = width
        self.height = height
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.text = text
        self.fontName = fontName
        self.fontWeight = fontWeight
        self.scaleFactor = scaleFactor

    }
    
    static func ==(lhs: CompositionProps, rhs: CompositionProps) -> Bool {
        // Compare all properties for equality
        return lhs.type == rhs.type &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.offsetX == rhs.offsetX &&
            lhs.offsetY == rhs.offsetY &&
            lhs.opacity == rhs.opacity &&
            lhs.text == rhs.text &&
            lhs.fontName == rhs.fontName &&
            lhs.fontWeight == rhs.fontWeight &&
            lhs.scaleFactor == rhs.scaleFactor 
    }
}

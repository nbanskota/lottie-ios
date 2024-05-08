//
//  File.swift
//  
//
//  Created by Nitesh Bankshota on 7/5/2024.
//

import Foundation
public class CompositionProps: Equatable {
    
    let id: String
    var size: CGSize?
    var offsetX: Double?
    var offsetY: Double?
    var opacity: Double?
    var text: String?
    var fontName: String?
    var fontWeight: Int?
    var scaleFactor: Double?
    public var animatingLayer: LayerModel

    
    init(animatingLayer: LayerModel, size: CGSize? = nil, offsetX: Double? = nil, offsetY: Double? = nil, text: String? = nil, fontName: String? = nil, fontWeight: Int? = nil, scaleFactor: Double? = nil) {
        self.id = UUID().uuidString
        self.size = size
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.text = text
        self.fontName = fontName
        self.fontWeight = fontWeight
        self.scaleFactor = scaleFactor
        self.animatingLayer = animatingLayer
    }
    
    public func setAnimatingLayer(layer: LayerModel){
        self.animatingLayer = layer
    }
    
    public  func setSize(width: Double, height: Double){
        self.size = CGSize(width: width, height: height)
    }
    
    public func getHeight()-> Double{
        return Double(self.size?.height ?? 0)
    }
    
    public  func getWidth()-> Double{
        return Double(self.size?.width ?? 0)
    }
    
    
    public static func ==(lhs: CompositionProps, rhs: CompositionProps) -> Bool {
        // Compare all properties for equality
        return
            lhs.id == rhs.id
    }
}

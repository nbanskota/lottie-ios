//
//  File.swift
//  
//
//  Created by Nitesh Bankshota on 7/5/2024.
//

import Foundation
public class CompositionProps: Equatable {
    
    let id: String
    var size: CGSize? = nil
    var offsetX: Double? = nil
    var offsetY: Double? = nil
    var opacity: Double? = nil
    var text: String? = nil
    var fontName: String? = nil
    var fontWeight: Int? = nil
    var scaleFactor: Double? = nil
    public var animatingLayer: LayerModel

    
    init(animatingLayer: LayerModel) {
        self.id = animatingLayer.name
        self.animatingLayer = animatingLayer
        switch animatingLayer.type {
        case .precomp:
            self.size = CGSize(width: (animatingLayer as! PreCompLayerModel).width, height: (animatingLayer as! PreCompLayerModel).height)
            break
        case .solid:
            break
        case .image:
            break
        case .null:
            break
        case .shape:
            break
        case .text:
            break
        case .unknown:
            break
        }
    }

    
    //only applicable for Precomp layer
    public  func setSize(width: Double, height: Double){
        if(self.animatingLayer.type == .precomp){
            self.size = CGSize(width: width, height: height)
            (self.animatingLayer as! PreCompLayerModel).width = width
            (self.animatingLayer as! PreCompLayerModel).height = height
        }
        
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

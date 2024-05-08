//
//  TransformWrapper.swift
//
//
//  Created by Nitesh Bankshota on 7/5/2024.
//

import Foundation

public class TransformWrapper : CustomStringConvertible{

    var transform: Transform
    
    public init(transform: Transform) {
        self.transform = transform
    }
    
    // Method to update anchor point
    func updateAnchorPoint(_ anchorPoint: KeyframeGroup<LottieVector3D>) {
        transform.anchorPoint = anchorPoint
    }
    
    // Method to update position
    func updatePosition(_ position: KeyframeGroup<LottieVector3D>) {
        transform.position = position
    }
    
    // Method to update scale
    func updateScale(_ scale: KeyframeGroup<LottieVector3D>) {
        transform.scale = scale
    }
    
    // Method to update rotation on X axis
    func updateRotationX(_ rotationX: KeyframeGroup<LottieVector1D>) {
        transform.rotationX = rotationX
    }
    
    // Method to update rotation on Y axis
    func updateRotationY(_ rotationY: KeyframeGroup<LottieVector1D>) {
        transform.rotationY = rotationY
    }
    
    // Method to update rotation on Z axis
    func updateRotationZ(_ rotationZ: KeyframeGroup<LottieVector1D>) {
        transform.rotationZ = rotationZ
    }
    
    // Method to update opacity
    func updateOpacity(_ opacity: KeyframeGroup<LottieVector1D>) {
        transform.opacity = opacity
    }
    
    public var description: String {
        
        return "scale : \(transform.scale) \n position: \(transform.position)"
    }
    
    
    
}

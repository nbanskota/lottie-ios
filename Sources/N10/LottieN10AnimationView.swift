//
//  File.swift
//  
//
//  Created by Nitesh Banskota on 8/5/2024.
//

import SwiftUI

public class LottieN10AnimationView: LottieAnimationView{
    
    private var layerProperties: LayerProperties?
    
    public func setLayerProperties(layerProperties: LayerProperties?){
        self.layerProperties = layerProperties
    }
    
    func updateAnimation(newAnimation: LottieAnimation){
        self.animation = newAnimation
        self.play()
        relaodLottie()
    }
    
    func updateAnimation(forLayerWithKey key: String){
        if let layerIndex = self.animation?.layers.firstIndex{$0.name == key},
        let layer = self.layerProperties?[key]?.animatingLayer{
                self.animation?.layers[layerIndex] = layer
            updateAnimation(newAnimation: self.animation!)
            if let chest = layer as? PreCompLayerModel{
                NSLog("\(key) :: w: %f, h: %f", chest.width, chest.height)
            }
      
        }
    }
    
    func relaodLottie(){
        self.forceDisplayUpdate()
        NSLog("Reload Lottie view")
    }
    
    
    
   

    
}

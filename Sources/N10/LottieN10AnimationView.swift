//
//  File.swift
//  
//
//  Created by Nitesh Banskota on 8/5/2024.
//

import SwiftUI

public class LottieN10AnimationView: LottieAnimationView{
    
    func updateAnimation(newAnimation: LottieAnimation){
        self.animation = newAnimation
        relaodLottie()
    }
    
    func relaodLottie(){
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
    
    
    
   

    
}

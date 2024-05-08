//
//  LottieViewModel.swift
//  Lottie
//
//  Created by Nitesh Banskota on 7/5/2024.
//

import Foundation
import SwiftUI

public class LottieViewModel: ObservableObject {
    @Published var sliderValue: Double
    @Published var lottieSize: CGSize
    
    public init(sliderValue: Double = 0.5, lottieSize: CGSize = .zero) {
        self.sliderValue = sliderValue
        self.lottieSize = lottieSize
    }
    
    public func updateSliderValue(_ value: Double) {
        sliderValue = value
        NSLog(value.description)
    }
    
    public func updateLottieSize(_ size: CGSize) {
        lottieSize = size
    }
}

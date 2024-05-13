//
//  CompositionProps.swift
//
//
//  Created by Nitesh Bankshota on 7/5/2024.
//


enum TransformProperty: String {
    case position = "Position"
    case scale = "Scale"
    case rotation = "Rotation"
    case opacity = "Opacity"
    case strokeWidth = "Stroke Width"
    case color = "Color"
}

protocol TransformationObserver {
    func onValueChanged(keyPathValueProvider: KeyPathValueProvider)
}


import Foundation
public class Transformation {
    
    let keyPath: String

    init(keyPath: String) {
        self.keyPath = keyPath
    }
    
    
    func changeColor(r: Double, g: Double, b: Double, a: Double)-> KeyPathValueProvider{
        let color = LottieColor(r: r, g: g, b: b, a: a, denominator: .TwoFiftyFive)
        let colorValueProvider = ColorValueProvider(color)
        let keyPathValueProvider =   KeyPathValueProvider(valueProvider: colorValueProvider,
                                                          animationKeyPath: AnimationKeypath(keypath: "\(self.keyPath)"))
        return keyPathValueProvider
    }
    
    
    //MARK: Internal
    
    public func floatingValueProvider(value: CGFloat) -> KeyPathValueProvider{
        let floatValueProvider = FloatValueProvider(value)
        return KeyPathValueProvider(valueProvider: floatValueProvider,
                                    animationKeyPath: AnimationKeypath(keypath: self.keyPath))
    }
    
    public func pointValueProvider(value: CGPoint) -> KeyPathValueProvider{
        
        let pointValueProvider = PointValueProvider(value)
        return KeyPathValueProvider(valueProvider: pointValueProvider,
                                    animationKeyPath: AnimationKeypath(keypath: self.keyPath))
    }
    
    
}

//Wrapper to make things easy
public class KeyPathValueProvider {
    let valueProvider: any ValueProvider
    let animationKeyPath: AnimationKeypath
    
    init(valueProvider: any ValueProvider, animationKeyPath: AnimationKeypath) {
        self.valueProvider = valueProvider
        self.animationKeyPath = animationKeyPath
    }
    
    
}

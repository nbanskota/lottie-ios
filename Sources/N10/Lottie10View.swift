//
//  Lottie10View.swift
//  Lottie-iOS
//
//  Created by Nitesh Bankshota on 6/5/2024.
//
import SwiftUI

public struct Lottie10View: ViewRepresentable{
    
    let name: String    //This is lottieName
    let loop: LottieLoopMode    //Lottie loop mode
    let animationView: LottieN10AnimationView // lottie animation view
    let speed: CGFloat      //speed of the animation
    let scaleFactor: CGFloat    //How small or big the view can be: Default is set to 3 while initializing
    let callback: LayerPropsCallback
    var layerProperties : LayerProperties?
    
    // Add state variables to hold width and height
    
    public init(name: String,
                loop: LottieLoopMode = .loop,
                speed: CGFloat = 1,
                scaleFactor: CGFloat = 3,
                layerProps: LayerProperties?,
                callback: @escaping LayerPropsCallback
    ) {
        self.name = name
        self.loop = loop
        self.speed = speed
        self.animationView = LottieN10AnimationView(name: name)
        self.animationView.setLayerProperties(layerProperties: layerProps)
        self.scaleFactor = scaleFactor
        self.callback = callback
        self.layerProperties = layerProps
        layerProperties?.getObserverManger().addObserver(self)
        
        
    }
    
    public func makeUIView(context: Context) -> UIView {
        
        let customView = UIView(frame: .zero)
        customView.addSubview(self.animationView)
        
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.heightAnchor.constraint(equalTo: customView.heightAnchor).isActive = true
        self.animationView.widthAnchor.constraint(equalTo: customView.widthAnchor).isActive = true
        
        animationView.loopMode = loop
        animationView.play()
        animationView.animationSpeed = speed
        
        if let animatingLayers = animationView.animation?.layers{
            for animatingLayer in animatingLayers {
                var compositionProps = CompositionProps(animatingLayer: animatingLayer)
                layerProperties?[animatingLayer.name] = compositionProps
            }
            callback(layerProperties)
        }
        
        animationView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        return customView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        
        
    }
    
}


//To check what details are present in the layer model, an extension is created to print the string representation.
extension LayerModel: CustomDebugStringConvertible{
    public var debugDescription: String {
        let mirror = Mirror(reflecting: self)
        var description = "\(Swift.type(of: self)): \n"
        
        for (label, value) in mirror.children {
            if let label = label {
                description += "\(label): \(value)\n"
            }
        }
        
        return description
    }
}


extension Lottie10View: LayerPropertiesObserver {

    public func layerProperties(_ layerProperties: LayerProperties, didUpdateValue value: CompositionProps?, forKey key: String) {
        let newValueProvider = PointValueProvider(CGPoint(x: 0, y: -200))
        let keyPath = AnimationKeypath(keypath: "Boat.Boat_Water_Loop.Air.Group.Transform.Position")
        self.animationView.setValueProvider(newValueProvider, keypath: keyPath)
        self.animationView.updateAnimation(forLayerWithKey: key)
        self.animationView.logHierarchyKeypaths()
    }
    
    
}


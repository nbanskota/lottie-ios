//
//  LottieView.swift
//  Lottie
//
//  Created by Nitesh Banskota on 9/5/2024.
//

import SwiftUI
import Combine

public class DataModel: ObservableObject {
    @Published public var dictionary: [String: Any] = [:]
    
    public init() {
      
    }

    func updateDictionary(newValue: [String: Any]) {
        self.dictionary = newValue
    }
}

public struct NewLottieView: UIViewRepresentable {
    
  //  var layerDict: LottieLayerDict =  LottieLayerDict()
    let filename: String
    let animationView: LottieAnimationView
    var isPaused: Bool
    var scale: Double
    var speed: Float
    var opacity: Float?
    var positionX: Double?
    var positionY: Double?
    var rotation: Float?
     var dataModel: DataModel

    
    
    
    //MARK: Initializer
    public init(filename: String, isPaused: Bool, scale: Double, positionX: Double? = nil, positionY: Double? = nil, rotation: Float? = nil, opacity: Float? = 1.0, speed: Float, dataModel: DataModel) {
        self.filename = filename
        self.animationView = LottieAnimationView(name: filename)
        self.isPaused = isPaused
        self.scale = scale
        self.positionX = positionX
        self.positionY = positionY
        self.rotation = rotation
        self.opacity = opacity
        self.speed = speed
        self.dataModel = dataModel
        
    }
    
    
    //Instead of Returning animationView lets wrap it in UIView. This will make sense when working with Full screen views
    public func makeUIView(context: Context) -> UIView {
        
        let customView = UIView(frame: .zero)
        customView.addSubview(self.animationView)
        
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.heightAnchor.constraint(equalTo: customView.heightAnchor).isActive = true
        self.animationView.widthAnchor.constraint(equalTo: customView.widthAnchor).isActive = true
        
        animationView.loopMode = .loop
        animationView.contentMode = .scaleToFill

        for keyPath in self.animationView.allHierarchyKeypaths() {
            NSLog(keyPath)
            
        }
        return customView
    }
    
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        guard let animationView = (uiView.subviews.compactMap { $0 as? LottieAnimationView }).first else {
            return
        }
        updateAnimationState(animationView: animationView)
    }
    private func updateAnimationState(animationView: LottieAnimationView) {
        self.isPaused ? animationView.pause() : animationView.play()
        animationView.animationLayer?.opacity = self.opacity ?? 1.0
        animationView.animationSpeed = CGFloat(self.speed)
        let rotation = animationView.transform.rotated(by: 45.0)
        
        //This order is important, because the scale factor transformation is concatinated with rotation transformation. concatinating function goes through matrix multiplication so m1*m2 != m2*m1
        animationView.rotate(degrees: CGFloat(self.rotation ?? 0.0))
        animationView.scale(x: self.scale, y: self.scale)
     
        working(animationView)
        
        
        
    }
    
    func working(_ animationView: LottieAnimationView){
        
        for key in dataModel.dictionary.keys{
            let prefix = key.keyPathPrefix()
            let suffix = key.keyPathSuffix()
            let transformation = Transformation(keyPath: key)
  
                if let suffix = suffix{
                    let keyPathValueProvider: KeyPathValueProvider
                    guard let transformProperty = TransformProperty(rawValue: suffix) else {return}
                    switch transformProperty{
                    case .color:
                        guard let rgb = dataModel.dictionary[key] as? Dictionary<String, Double> else {return}
                        keyPathValueProvider = transformation.changeColor(r: rgb["r"] ?? 0.0, g: rgb["g"] ?? 0, b: rgb["b"] ?? 0, a: rgb["a"] ?? 1)
                        break
                    case .opacity, .rotation, .strokeWidth:
                        guard let value = dataModel.dictionary[key] as? Double else {return}
                        keyPathValueProvider = transformation.floatingValueProvider(value: value)
                        break
                        
                    case .position, .scale:
                        guard let position = dataModel.dictionary[key] as? Dictionary<String, Double> else {return}
                        keyPathValueProvider = transformation.pointValueProvider(value: CGPoint(x: Int(position["x"] ?? 0.0), y: Int(position["y"] ?? 0.0)))
                        break
                    
                    }
                    animationView.setValueProvider( keyPathValueProvider.valueProvider, keypath: keyPathValueProvider.animationKeyPath)
                }
                
        }
    }
    
}



extension UIView {
    func rotate(degrees: CGFloat) {
        let radians = degrees * .pi / 180.0
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
    func scale(x: CGFloat, y: CGFloat) {
        self.transform = self.transform.concatenating(CGAffineTransform(scaleX: x, y: y))
    }
    
}

extension String {
    func keyPathSuffix() -> String?{
        let components = self.components(separatedBy: ".")
        return components.last
    }
    func keyPathPrefix() -> String{
        let components = self.components(separatedBy: ".")
        let prefixes = components.dropLast()
        return prefixes.joined(separator: ".")
    }
}

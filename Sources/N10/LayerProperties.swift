
//
//  LayerProperties.swift
//
//
//  Created by Nitesh Bankshota on 7/5/2024.
//


///The key "Key"  is usually the layer name
///Value : holds properties for particular layer type
///
///
import SwiftUI

public protocol LayerPropertiesObserver  {
    func layerProperties(_ layerProperties: LayerProperties, didUpdateValue value: CompositionProps?, forKey key: String)
}

public class ObserverManager : ObservableObject {
    private var observers: [LayerPropertiesObserver]
    
    public init() {
        self.observers = []
    }
    
    public func addObserver(_ observer: LayerPropertiesObserver) {
        observers.append(observer)
    }
    
    public func removeObserver(_ observer: LayerPropertiesObserver) {
      //  observers.removeAll { $0 === observer }
    }
    
    public func notifyObservers(_ layerProperties: LayerProperties, didUpdateValue value: CompositionProps?, forKey key: String) {
        for observer in observers {
            observer.layerProperties(layerProperties, didUpdateValue: value, forKey: key)
          
        }
    }
}



public class LayerProperties {
    public var dictionary: [String: CompositionProps]
    private var observerManager: ObserverManager
    
    public init(dictionary: [String: CompositionProps] = [:], observerManager: ObserverManager) {
          self.dictionary = dictionary
          self.observerManager = observerManager
      }
    
    public func getObserverManger()-> ObserverManager{
        return self.observerManager
    }
    
    
    public subscript(key: String) -> CompositionProps? {
        get {
            return dictionary[key]
        }
        set(newValue) {
                    if let newValue = newValue {
                        if dictionary[key] != newValue {
                            dictionary[key] = newValue
                            observerManager.notifyObservers(self, didUpdateValue: newValue, forKey: key)
                        }
                    } else {
                        dictionary.removeValue(forKey: key)
                        observerManager.notifyObservers(self, didUpdateValue: newValue, forKey: key)
                    }
                }
    }
    
    //update
    public func updateValue(_ value: CompositionProps, forKey key: String) {
        dictionary[key] = value
        observerManager.notifyObservers(self, didUpdateValue: value, forKey: key)
    }
    //remove
    public func removeValue(forKey key: String) {
        dictionary.removeValue(forKey: key)
    }
    //check if contains keys
    public func containsKey(_ key: String) -> Bool {
        return dictionary.keys.contains(key)
    }
    
    public var count: Int {
        return dictionary.count
    }
    
    public var isEmpty: Bool {
        return dictionary.isEmpty
    }
    
    public func forEach(_ body: ((key: String, value: CompositionProps)) throws -> Void) rethrows {
        try dictionary.forEach(body)
    }
}

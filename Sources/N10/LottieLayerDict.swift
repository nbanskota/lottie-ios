//
//  File.swift
//  
//
//  Created by Nitesh Banskota on 9/5/2024.
//



///The key "Key"  is usually the layer name
///Value : holds properties for particular layer type
///
///
import SwiftUI


public class LottieLayerDict {
    public var dictionary: [String: Transformation]
    
    public init(dictionary: [String: Transformation] = [:]) {
          self.dictionary = dictionary
      }

    
    public subscript(key: String) -> Transformation? {
        get {
            return dictionary[key]
        }
        set(newValue) {
                    if let newValue = newValue {
                        if dictionary[key]?.keyPath != newValue.keyPath {
                            dictionary[key] = newValue //add to dict if value does not exist
                        }else{
                            updateValue(newValue, forKey: key) //update value if key is already present
                        }
                    } else {
                        dictionary.removeValue(forKey: key)
                    }
                }
    }
    
    //update
    public func updateValue(_ value: Transformation, forKey key: String) {
        dictionary[key] = value
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
    
    public func forEach(_ body: ((key: String, value: Transformation)) throws -> Void) rethrows {
        try dictionary.forEach(body)
    }
}

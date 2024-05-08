//
//  IosDeviceTypeAlias.swift
//  Lottie-iOS
//
//  Created by Nitesh Bankshota on 6/5/2024.
//

import Foundation
import SwiftUI

public typealias LayerPropsCallback = (LayerProperties?) -> Void

#if os(macOS)

public typealias NativeView = NSView
public typealias NativeApplication = NSApplication
public typealias ViewRepresentable = NSViewRepresentable
public typealias ViewControllerRepresentable = NSViewControllerRepresentable

#elseif os(iOS)

public typealias NativeView = UIView
public typealias NativeApplication = UIApplication
public typealias ViewRepresentable = UIViewRepresentable
public typealias ViewControllerRepresentable = UIViewControllerRepresentable

#endif


//
//  Animatable.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/6/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import Foundation
import Loaf

protocol Animatable {
    
}

extension Animatable where Self: UIViewController{
    
    func showInfoToToast(message: String, location: Loaf.Location, duration: TimeInterval = 1.0) {
        DispatchQueue.main.async {
            Loaf(message,
                 state: .info,
                 location: location,
                 sender: self)
                .show(.custom(duration))
        }
    }
}

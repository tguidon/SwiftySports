//
//  SoccerField.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/25/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class SoccerField {
    let kRealCourtWidth: CGFloat = 78.0
    let kRealCourtHeight: CGFloat = 36.0
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var lineWidth: CGFloat = 0
    
    func initWithWidth(_ width: CGFloat) {
        self.width = width
        updateConstants()
    }
    
    func updateConstants() {
        self.height = width * (6 / 13)
    }
}

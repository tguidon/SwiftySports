//
//  TennisCourt.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/25/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class TennisCourt {
    let kRealCourtWidth: CGFloat = 78.0
    let kRealCourtHeight: CGFloat = 36.0
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var sidelineOffset: CGFloat = 0
    var serviceLineOffset: CGFloat = 0
    
    var lineWidth: CGFloat = 0
    
    func initWithWidth(_ width: CGFloat) {
        self.width = width
        updateConstants()
    }
    
    func updateConstants() {
        self.height = width * (6 / 13)
        
        let lineWidthRatio: CGFloat = 0.65 / kRealCourtWidth
        self.lineWidth = width * lineWidthRatio
        
        let sidelineOffsetRatio: CGFloat = 4.5 / kRealCourtHeight
        self.sidelineOffset = height * sidelineOffsetRatio
        
        let serviceLineOffsetRatio: CGFloat = 21 / kRealCourtWidth
        self.serviceLineOffset = width * serviceLineOffsetRatio
    }
}

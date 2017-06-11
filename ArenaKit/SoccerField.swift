//
//  SoccerField.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/25/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class SoccerField {
    // Don't change these constants, used for ratios
    let kRealFieldWidth: CGFloat = 105.0
    let kRealFieldHeight: CGFloat = 68.0
    
    // Setup temp
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    // offset
    var soccerFieldOffset: CGFloat = 0
    var penaltyDotOffset: CGFloat = 0
    
    // UI widths
    var lineWidth: CGFloat = 1
    var centerCircleWidth: CGFloat = 1
    var centerCircleDotWidth: CGFloat = 1
    var goalWidth: CGFloat = 1
    var goalHeight: CGFloat = 1
    var goalAreaWidth: CGFloat = 1
    var goalAreaHeight: CGFloat = 1
    var penaltyAreaWidth: CGFloat = 1
    var penaltyAreaHeight: CGFloat = 1
    var areaCurveWidth: CGFloat = 1
    var areaCurveHeight: CGFloat = 1
    var cornerWidth: CGFloat = 1
    
    func initWithWidth(_ width: CGFloat) {
        self.width = width - soccerFieldOffset
        self.soccerFieldOffset = (self.width * (5 / self.kRealFieldWidth))
        
        updateConstants()
    }
    
    func updateConstants() {
        height = width * (68 / 105)
        
        let penaltyDotOffsetRatio: CGFloat = 12 / kRealFieldWidth
        penaltyDotOffset = width * penaltyDotOffsetRatio
        
        let lineWidthRatio: CGFloat = 0.7 / kRealFieldWidth
        lineWidth = width * lineWidthRatio
        
        let centerCircleWidthRatio: CGFloat = 20 / kRealFieldWidth
        centerCircleWidth = width * centerCircleWidthRatio
        
        let centerCircleDotWidthRatio: CGFloat = 1 / kRealFieldWidth
        centerCircleDotWidth = width * centerCircleDotWidthRatio
        
        let goalWidthRatio: CGFloat = 4 / kRealFieldWidth
        goalWidth = width * goalWidthRatio
        
        let goalHeightRatio: CGFloat = 8 / kRealFieldHeight
        goalHeight = height * goalHeightRatio
        
        let goalAreaWidthRatio: CGFloat = 6 / kRealFieldWidth
        goalAreaWidth = width * goalAreaWidthRatio
        
        let goalAreaHeightRatio: CGFloat = 20 / kRealFieldHeight
        goalAreaHeight = height * goalAreaHeightRatio
        
        let penaltyAreaWidthRatio: CGFloat = 18 / kRealFieldWidth
        penaltyAreaWidth = width * penaltyAreaWidthRatio
        
        let penaltyAreaHeightRatio: CGFloat = 44 / kRealFieldHeight
        penaltyAreaHeight = height * penaltyAreaHeightRatio
        
        let areaCurveWidthRatio: CGFloat = 4 / kRealFieldWidth
        areaCurveWidth = width * areaCurveWidthRatio
        
        let areaCurveHeightRatio: CGFloat = 18 / kRealFieldHeight
        areaCurveHeight = height * areaCurveHeightRatio
        
        let cornerWidthRatio: CGFloat = 2.5 / kRealFieldWidth
        cornerWidth = width * cornerWidthRatio
    }
}

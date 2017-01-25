//
//  IceRink.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/25/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class IceRink {
    // Don't change these constants, used for ratios
    let kRealRinkWidth: CGFloat = 200.0
    let kRealRinkHeight: CGFloat = 85.0
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    // Ratios based on real rink values
    var rinkCornerRatio: CGFloat = 0
    var boardWidthRatio: CGFloat = 0
    
    // UI offets
    var goalLineOffset: CGFloat = 0
    var blueLineOffset: CGFloat = 0
    var neutralDotOffset: CGFloat = 0
    var faceoffHorizontalOffset: CGFloat = 0
    var faceoffVerticalOffset: CGFloat = 0
    
    //  UI widths
    var boardWidth: CGFloat = 1
    var minorLineWidth: CGFloat = 1
    var majorLineWidth: CGFloat = 1
    var circleWidth: CGFloat = 1
    var dotWidth: CGFloat = 1
    var centerDotWidth: CGFloat = 1
    var creaseWidth: CGFloat = 1
    var creaseHeight: CGFloat = 1
    
    func initWithWidth(_ width: CGFloat) {
        self.width = width
        updateConstants()
    }
    
    func updateConstants() {
        height = width * (17 / 40)
        
        print(width, height)
        
        rinkCornerRatio = 28.0 / kRealRinkWidth
        boardWidthRatio = 1.5 / kRealRinkWidth
        
        let minorLineWidthRatio: CGFloat = 1.0 / kRealRinkWidth
        let majorLineWidthRatio: CGFloat = 2.0 / kRealRinkWidth
        minorLineWidth = width * minorLineWidthRatio
        majorLineWidth = width * majorLineWidthRatio
        
        let goalLineOffsetRatio: CGFloat = 11 / kRealRinkWidth
        goalLineOffset = width * goalLineOffsetRatio
        
        let blueLineOffsetRatio: CGFloat = 64 / kRealRinkWidth
        blueLineOffset = width * blueLineOffsetRatio
        
        let neutralDotRatio: CGFloat = 5 / kRealRinkWidth
        neutralDotOffset = width * neutralDotRatio
        
        let circleSizeRatio: CGFloat = 30 / kRealRinkWidth
        circleWidth = width * circleSizeRatio
        
        let dotSizeRatio: CGFloat = 2.5 / kRealRinkWidth
        dotWidth = width * dotSizeRatio
        
        let centerDotSizeRatio: CGFloat = 1.5 / kRealRinkWidth
        centerDotWidth = width * centerDotSizeRatio
        
        let faceoffCircleRatio: CGFloat = 22 / kRealRinkWidth
        let faceOffGapRatio: CGFloat = 44 / kRealRinkHeight
        faceoffHorizontalOffset = width * faceoffCircleRatio
        faceoffVerticalOffset = (height * faceOffGapRatio) / 2
        
        let creaseWidthRatio: CGFloat = 6 / kRealRinkWidth
        let creaseHeightRatio: CGFloat = 8 / kRealRinkHeight
        creaseWidth = width * creaseWidthRatio
        creaseHeight = height * creaseHeightRatio
    }
}

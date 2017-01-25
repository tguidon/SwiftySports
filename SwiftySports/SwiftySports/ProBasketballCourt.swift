//
//  ProBasketballCourt.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/25/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class ProBasketballCourt {
    // Don't change these constants, used for ratios
    let kRealCourtWidth: CGFloat = 94.0
    let kRealCourtHeight: CGFloat = 50.0
    
    // temp w and h
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var lineWidth: CGFloat = 0
    var smallCircleWidth: CGFloat = 0
    var largeCircleWidth: CGFloat = 0
    var hashMarkHeight: CGFloat = 0
    var zoneViewWidth: CGFloat = 0
    var zoneViewHeight: CGFloat = 0
    var zoneStraightLineWidth: CGFloat = 0
    var boxWidth: CGFloat = 0
    var smallBoxHeight: CGFloat = 0
    var largeBoxHeight: CGFloat = 0
    var hoopWidth: CGFloat = 0
    var backboardHeight: CGFloat = 0
    
    var hashMarkOffset: CGFloat = 0
    var backboardOffset: CGFloat = 0
    var boxHashOffset: CGFloat = 00
    
    func initWithWidth(_ width: CGFloat) {
        self.width = width
        updateConstants()
    }
    
    func updateConstants() {
        self.height = width * (25 / 47)
        
        // .85
        let lineWidthRatio: CGFloat = 0.65 / kRealCourtWidth
        lineWidth = width * lineWidthRatio
        
        let smallCircleWidthRatio: CGFloat = 4 / kRealCourtWidth
        smallCircleWidth = width * smallCircleWidthRatio
        let largeCircleWidthRatio: CGFloat = 12 / kRealCourtWidth
        largeCircleWidth = width * largeCircleWidthRatio
        
        let hashMarkHeightRatio: CGFloat = 2.5 / kRealCourtHeight
        hashMarkHeight = height * hashMarkHeightRatio
        
        let hashMarkOffsetRatio: CGFloat = 28 / kRealCourtWidth
        hashMarkOffset = width * hashMarkOffsetRatio
        
        // 29
        let zoneViewWidthRatio: CGFloat = 29 / kRealCourtWidth
        zoneViewWidth = width * zoneViewWidthRatio
        let zoneViewHeightRatio: CGFloat = 44 / kRealCourtHeight
        zoneViewHeight = height * zoneViewHeightRatio
        let zoneStraightLineWidthRatio: CGFloat = 14 / kRealCourtWidth
        zoneStraightLineWidth = width * zoneStraightLineWidthRatio
        
        let boxWidthRatio: CGFloat = 19 / kRealCourtWidth
        boxWidth = width * boxWidthRatio
        let smallBoxHeightRatio: CGFloat = 12 / kRealCourtHeight
        smallBoxHeight = height * smallBoxHeightRatio
        let largeBoxHeightRatio: CGFloat = 16 / kRealCourtHeight
        largeBoxHeight = height * largeBoxHeightRatio
        
        let backboardOffsetRatio: CGFloat = 4 / kRealCourtWidth
        backboardOffset = width * backboardOffsetRatio
        let boxHashOffsetRatio: CGFloat = 3 / kRealCourtWidth
        boxHashOffset = width * boxHashOffsetRatio
        
        let hoopWidthRatio: CGFloat = 2 / kRealCourtWidth
        hoopWidth = width * hoopWidthRatio
        let backboardHeightRatio: CGFloat = 6 / kRealCourtHeight
        backboardHeight = height * backboardHeightRatio
    }
}

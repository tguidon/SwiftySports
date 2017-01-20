//
//  TennisCourtView.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

protocol TennisCourtViewDataSource {
    func widthForCourt(_ tennisCourtView: TennisCourtView) -> CGFloat
}

class TennisCourtView: UIView {
    
    var dataSource: TennisCourtViewDataSource?
    
    // Don't change these constants, used for ratios
    private let kRealCourtWidth: CGFloat = 78.0
    private let kRealCourtHeight: CGFloat = 36.0
    
    // UI
    // tennisCourtView holds the rink's UI elements
    // dataView holds potential data overlays
    private let tennisCourtView = UIView()
    private let dataView = UIView()
    
    private let netLine = UIView()
    private let topSinglesSideline = UIView()
    private let bottomSinglesSideline = UIView()
    private let leftServiceLine = UIView()
    private let rightServiceLine = UIView()
    private let leftCenterServiceLine = UIView()
    private let rightCenterServiceLine = UIView()
    
    // Array of all lines
    private var courtLines: [UIView] = []
    
    // Colors with a redraw on set tp update view
    var courtColor: UIColor = UIColor(red:0.55, green:0.84, blue:0.57, alpha:1.00) {
        didSet {
            drawToScale()
        }
    }
    var lineColor: UIColor = .white {
        didSet {
            drawToScale()
        }
    }
    
    // Setup temp
    private var tennisCourtViewWidth: CGFloat = 0
    private var tennisCourtViewHeight: CGFloat = 0
    
    // Offsets
    private var sidelineOffset: CGFloat = 0
    private var serviceLineOffset: CGFloat = 0
    
    // UI widths
    private var lineWidth: CGFloat = 0
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of lines
        courtLines = [netLine, topSinglesSideline, bottomSinglesSideline, leftServiceLine,
                      rightServiceLine, leftCenterServiceLine, rightCenterServiceLine]
        
        self.backgroundColor = .clear
        
        setupConstants()
    }
    
    func setupConstants() {
        tennisCourtViewHeight = tennisCourtViewWidth * (6 / 13)
        
        let lineWidthRatio: CGFloat = 0.65 / kRealCourtWidth
        lineWidth = tennisCourtViewWidth * lineWidthRatio
        
        let sidelineOffsetRatio: CGFloat = 4.5 / kRealCourtHeight
        sidelineOffset = tennisCourtViewHeight * sidelineOffsetRatio
        
        let serviceLineOffsetRatio: CGFloat = 21 / kRealCourtWidth
        serviceLineOffset = tennisCourtViewWidth * serviceLineOffsetRatio        
    }
    
    func drawCourt() {
        // Add the base green court
        tennisCourtView.backgroundColor = courtColor
        tennisCourtView.translatesAutoresizingMaskIntoConstraints = false
        tennisCourtView.layer.borderColor = lineColor.cgColor
        tennisCourtView.layer.borderWidth = lineWidth
        self.addSubview(tennisCourtView)
        tennisCourtView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalToSuperview()
        }
        
        // Set up all the lines and add to view
        for line in courtLines {
            line.backgroundColor = lineColor
            line.translatesAutoresizingMaskIntoConstraints = false
            tennisCourtView.addSubview(line)
        }
        
        // Constraints for net
        netLine.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // sidelines
        topSinglesSideline.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(sidelineOffset)
            make.height.equalTo(lineWidth)
        }
        bottomSinglesSideline.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-sidelineOffset)
            make.height.equalTo(lineWidth)
        }
        
        // add the service lines
        leftServiceLine.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(-serviceLineOffset)
        }
        rightServiceLine.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(serviceLineOffset)
        }
        
        // add the center service lines
        leftCenterServiceLine.snp.makeConstraints { (make) in
            make.height.equalTo(lineWidth)
            make.left.equalTo(leftServiceLine.snp.right)
            make.right.equalTo(netLine.snp.left)
            make.centerY.equalToSuperview()
        }
        rightCenterServiceLine.snp.makeConstraints { (make) in
            make.height.equalTo(lineWidth)
            make.left.equalTo(netLine.snp.right)
            make.right.equalTo(rightServiceLine.snp.left)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func drawToScale() {
        guard let width = dataSource?.widthForCourt(self) else {
            print("No width set in dataSource")
            return
        }
        
        tennisCourtViewWidth = width
        setupConstants()
        drawCourt()
    }

}

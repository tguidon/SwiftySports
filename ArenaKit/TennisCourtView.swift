//
//  TennisCourtView.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

class TennisCourtView: UIView {
    
    let tennisCourt = TennisCourt()
    
    // UI
    // tennisCourtView holds the court's UI elements
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
            tennisCourtView.backgroundColor = courtColor
        }
    }
    var lineColor: UIColor = .white {
        didSet {
            courtLines.forEach({ $0.backgroundColor = lineColor })
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of lines
        courtLines = [netLine, topSinglesSideline, bottomSinglesSideline, leftServiceLine,
                      rightServiceLine, leftCenterServiceLine, rightCenterServiceLine]
        
        self.backgroundColor = .clear
    }
    
    func setup() {
        // Add the base green court
        tennisCourtView.backgroundColor = courtColor
        tennisCourtView.translatesAutoresizingMaskIntoConstraints = false
        tennisCourtView.layer.borderColor = lineColor.cgColor
        self.addSubview(tennisCourtView)
        // Set up all the lines and add to view
        courtLines.forEach({ $0.backgroundColor = lineColor })
        courtLines.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        courtLines.forEach({ tennisCourtView.addSubview($0) })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tennisCourt.initWithWidth(self.frame.width)
        draw()
    }
    
    private func draw() {
        tennisCourtView.layer.borderWidth = tennisCourt.lineWidth
        
        // Set up main court view
        tennisCourtView.snp.remakeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        // Constraints for net
        netLine.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(tennisCourt.lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // Sidelines
        topSinglesSideline.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(tennisCourt.sidelineOffset)
            make.height.equalTo(tennisCourt.lineWidth)
        }
        bottomSinglesSideline.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tennisCourt.sidelineOffset)
            make.height.equalTo(tennisCourt.lineWidth)
        }
        
        // Add the service lines
        leftServiceLine.snp.remakeConstraints { (make) in
            make.width.equalTo(tennisCourt.lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(-tennisCourt.serviceLineOffset)
        }
        rightServiceLine.snp.remakeConstraints { (make) in
            make.width.equalTo(tennisCourt.lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(tennisCourt.serviceLineOffset)
        }
        
        // Add the center service lines
        leftCenterServiceLine.snp.remakeConstraints { (make) in
            make.height.equalTo(tennisCourt.lineWidth)
            make.left.equalTo(leftServiceLine.snp.right)
            make.right.equalTo(netLine.snp.left)
            make.centerY.equalToSuperview()
        }
        rightCenterServiceLine.snp.remakeConstraints { (make) in
            make.height.equalTo(tennisCourt.lineWidth)
            make.left.equalTo(netLine.snp.right)
            make.right.equalTo(rightServiceLine.snp.left)
            make.centerY.equalToSuperview()
        }
    }
}

//
//  SoccerFieldView.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

protocol SoccerFieldViewDataSource {
    func widthForSoccerField(_ soccerFieldView: SoccerFieldView) -> CGFloat
}

class SoccerFieldView: UIView {
    
    var dataSource: SoccerFieldViewDataSource?
    
    // Don't change these constants, used for ratios
    private let kRealFieldWidth: CGFloat = 105.0
    private let kRealFieldHeight: CGFloat = 68.0
    
    // UI
    // soccerFieldView holds the rink's UI elements
    // dataView holds potential data overlays
    private let soccerFieldView = UIView()
    private let dataView = UIView()
    
    // all the lines
    private let centerCircleView = UIView()
    private let centerCircleDotView = UIView()
    private let midFieldLineView = UIView()
    private let homeGoalView = UIView()
    private let awayGoalView = UIView()
    private let homeGoalAreaView = UIView()
    private let awayGoalAreaView = UIView()
    private let homePenaltyAreaView = UIView()
    private let awayPenaltyAreaView = UIView()
    private let homeAreaCurveView = UIView()
    private let awayAreaCurveView = UIView()
    private let topLeftCornerView = UIView()
    private let bottomLeftCornerView = UIView()
    private let topRightCornerView = UIView()
    private let bottomRightCornerView = UIView()
    
    // Array of all lines
    private var fieldLines: [UIView] = []
    private var cornerViews: [UIView] = []
    
    // Colors with a redraw on set tp update view
    var fieldColor: UIColor = UIColor(red:0.55, green:0.84, blue:0.57, alpha:1.00) {
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
    private var soccerFieldViewWidth: CGFloat = 0
    private var soccerFieldViewHeight: CGFloat = 0
    
    // offset
    private var soccerFieldOffset: CGFloat = 0
    
    // UI widths
    private var lineWidth: CGFloat = 1
    private var centerCircleWidth: CGFloat = 1
    private var centerCircleDotWidth: CGFloat = 1
    private var goalWidth: CGFloat = 1
    private var goalHeight: CGFloat = 1
    private var goalAreaWidth: CGFloat = 1
    private var goalAreaHeight: CGFloat = 1
    private var penaltyAreaWidth: CGFloat = 1
    private var penaltyAreaHeight: CGFloat = 1
    private var areaCurveWidth: CGFloat = 1
    private var areaCurveHeight: CGFloat = 1
    private var cornerWidth: CGFloat = 1
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of lines
        fieldLines = [centerCircleView, centerCircleDotView, midFieldLineView, homeGoalView, awayGoalView,
                      homeGoalAreaView, awayGoalAreaView, homePenaltyAreaView, awayPenaltyAreaView]
        cornerViews = [topLeftCornerView, bottomLeftCornerView, topRightCornerView, bottomRightCornerView]

        self.backgroundColor = .red
        
        setupConstants()
    }
    
    func setupConstants() {
        soccerFieldViewHeight = soccerFieldViewWidth * (1 / 1)
    }
    
    func drawField() {
        soccerFieldView.backgroundColor = fieldColor
        soccerFieldView.translatesAutoresizingMaskIntoConstraints = false
        soccerFieldView.layer.borderColor = lineColor.cgColor
        soccerFieldView.layer.borderWidth = 1
        self.addSubview(soccerFieldView)
        soccerFieldView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(soccerFieldOffset)
            make.right.equalToSuperview().offset(-soccerFieldOffset)
        }
    }
    
    func drawToScale() {
        guard let width = dataSource?.widthForSoccerField(self) else {
            print("No width set in dataSource")
            return
        }
        
        soccerFieldOffset = (width * (5 / kRealFieldWidth))
        soccerFieldViewWidth = width - soccerFieldOffset
        setupConstants()
        drawField()
    }
    
}

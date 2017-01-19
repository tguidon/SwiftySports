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
    private let homePenaltyDotView = UIView()
    private let awayPenaltyDotView = UIView()
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
    private var fieldDots: [UIView] = []
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
    private var penaltyDotOffset: CGFloat = 0
    
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
        fieldLines = [centerCircleView, midFieldLineView, homeGoalView, awayGoalView,
                      homeGoalAreaView, awayGoalAreaView, homePenaltyAreaView, awayPenaltyAreaView]
        fieldDots = [centerCircleDotView, homePenaltyDotView, awayPenaltyDotView]
        cornerViews = [topLeftCornerView, bottomLeftCornerView, topRightCornerView, bottomRightCornerView]

        self.backgroundColor = fieldColor
        
        setupConstants()
    }
    
    func setupConstants() {
        soccerFieldViewHeight = soccerFieldViewWidth * (68 / 105)
        
        let penaltyDotOffsetRatio: CGFloat = 12 / kRealFieldWidth
        penaltyDotOffset = soccerFieldViewWidth * penaltyDotOffsetRatio
        
        let lineWidthRatio: CGFloat = 0.5 / kRealFieldWidth
        lineWidth = soccerFieldViewWidth * lineWidthRatio
        
        let centerCircleWidthRatio: CGFloat = 20 / kRealFieldWidth
        centerCircleWidth = soccerFieldViewWidth * centerCircleWidthRatio
        
        let centerCircleDotWidthRatio: CGFloat = 1 / kRealFieldWidth
        centerCircleDotWidth = soccerFieldViewWidth * centerCircleDotWidthRatio
        
        let goalWidthRatio: CGFloat = 4 / kRealFieldWidth
        goalWidth = soccerFieldViewWidth * goalWidthRatio
        
        let goalHeightRatio: CGFloat = 8 / kRealFieldHeight
        goalHeight = soccerFieldViewHeight * goalHeightRatio
        
        let goalAreaWidthRatio: CGFloat = 6 / kRealFieldWidth
        goalAreaWidth = soccerFieldViewWidth * goalAreaWidthRatio
        
        let goalAreaHeightRatio: CGFloat = 20 / kRealFieldHeight
        goalAreaHeight = soccerFieldViewHeight * goalAreaHeightRatio
        
        let penaltyAreaWidthRatio: CGFloat = 18 / kRealFieldWidth
        penaltyAreaWidth = soccerFieldViewWidth * penaltyAreaWidthRatio
        
        let penaltyAreaHeightRatio: CGFloat = 44 / kRealFieldHeight
        penaltyAreaHeight = soccerFieldViewHeight * penaltyAreaHeightRatio
        
        let areaCurveWidthRatio: CGFloat = 4 / kRealFieldWidth
        areaCurveWidth = soccerFieldViewWidth * areaCurveWidthRatio
        
        let areaCurveHeightRatio: CGFloat = 18 / kRealFieldHeight
        areaCurveHeight = soccerFieldViewHeight * areaCurveHeightRatio
        
        let cornerWidthRatio: CGFloat = 1.5 / kRealFieldWidth
        cornerWidth = soccerFieldViewWidth * cornerWidthRatio
    }
    
    func drawField() {
        self.backgroundColor = fieldColor
        // add the main soccer view and add an offset for the nets
        soccerFieldView.backgroundColor = fieldColor
        soccerFieldView.translatesAutoresizingMaskIntoConstraints = false
        soccerFieldView.layer.borderColor = lineColor.cgColor
        soccerFieldView.layer.borderWidth = lineWidth
        self.addSubview(soccerFieldView)
        soccerFieldView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(soccerFieldOffset)
            make.right.equalToSuperview().offset(-soccerFieldOffset)
        }
        // must be set for the goals
        soccerFieldView.clipsToBounds = false
        
        // set up the lines and dots and add to view
        for line in fieldLines {
            line.backgroundColor = .clear
            line.translatesAutoresizingMaskIntoConstraints = false
            line.layer.borderColor = lineColor.cgColor
            line.layer.borderWidth = lineWidth
            soccerFieldView.addSubview(line)
        }
        for dot in fieldDots {
            dot.backgroundColor = lineColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            soccerFieldView.addSubview(dot)
        }
        
        // add the goals
        homeGoalView.snp.makeConstraints { (make) in
            make.right.equalTo(soccerFieldView.snp.left).offset(lineWidth)
            make.width.equalTo(goalWidth)
            make.height.equalTo(goalHeight)
            make.centerY.equalToSuperview()
        }
        awayGoalView.snp.makeConstraints { (make) in
            make.left.equalTo(soccerFieldView.snp.right).offset(-lineWidth)
            make.width.equalTo(goalWidth)
            make.height.equalTo(goalHeight)
            make.centerY.equalToSuperview()
        }
        homeGoalView.backgroundColor = fieldColor
        awayGoalView.backgroundColor = fieldColor
        
        // add midfield line
        midFieldLineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // add the penalty area
        homePenaltyAreaView.snp.makeConstraints { (make) in
            make.left.equalTo(soccerFieldView.snp.left)
            make.width.equalTo(penaltyAreaWidth)
            make.height.equalTo(penaltyAreaHeight)
            make.centerY.equalToSuperview()
        }
        awayPenaltyAreaView.snp.makeConstraints { (make) in
            make.right.equalTo(soccerFieldView.snp.right)
            make.width.equalTo(penaltyAreaWidth)
            make.height.equalTo(penaltyAreaHeight)
            make.centerY.equalToSuperview()
        }
        
        // add the goal area
        homeGoalAreaView.snp.makeConstraints { (make) in
            make.left.equalTo(soccerFieldView.snp.left)
            make.width.equalTo(goalAreaWidth)
            make.height.equalTo(goalAreaHeight)
            make.centerY.equalToSuperview()
        }
        awayGoalAreaView.snp.makeConstraints { (make) in
            make.right.equalTo(soccerFieldView.snp.right)
            make.width.equalTo(goalAreaWidth)
            make.height.equalTo(goalAreaHeight)
            make.centerY.equalToSuperview()
        }

        // add the penalty dots
        homePenaltyDotView.snp.makeConstraints { (make) in
            make.width.equalTo(centerCircleDotWidth)
            make.height.equalTo(centerCircleDotWidth)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(soccerFieldView.snp.left).offset(penaltyDotOffset)
        }
        awayPenaltyDotView.snp.makeConstraints { (make) in
            make.width.equalTo(centerCircleDotWidth)
            make.height.equalTo(centerCircleDotWidth)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(soccerFieldView.snp.right).offset(-penaltyDotOffset)
        }
        homePenaltyDotView.layer.cornerRadius = centerCircleDotWidth / 2
        awayPenaltyDotView.layer.cornerRadius = centerCircleDotWidth / 2

        
        // add the center circle and dot
        centerCircleView.snp.makeConstraints { (make) in
            make.width.equalTo(centerCircleWidth)
            make.height.equalTo(centerCircleWidth)
            make.center.equalToSuperview()
        }
        centerCircleDotView.snp.makeConstraints { (make) in
            make.width.equalTo(centerCircleDotWidth)
            make.height.equalTo(centerCircleDotWidth)
            make.center.equalToSuperview()
        }
        centerCircleView.layer.cornerRadius = centerCircleWidth / 2
        centerCircleDotView.layer.cornerRadius = centerCircleDotWidth / 2
        
//        let homeGoalShapeLayer = CAShapeLayer()
//        let awayGoalShapeLayer = CAShapeLayer()
//        let goalShapeLayers: [CAShapeLayer] = [homeGoalShapeLayer, awayGoalShapeLayer]
//        for goal in goalShapeLayers {
//            // Bezier path to get that curve on the crease
//            goal.path = returnGoalBezierPath().cgPath
//            goal.strokeColor = redLineColor.cgColor
//            goal.fillColor = creaseColor.cgColor
//            goal.position = CGPoint(x: 0, y: 0)
//            goal.lineWidth = minorLineWidth * 0.5
//        }
//        homeCrease.layer.addSublayer(homeGoalShapeLayer)
//        awayCrease.layer.addSublayer(awayGoalShapeLayer)
        
        // add the corners
        for corner in cornerViews {
            corner.backgroundColor = .clear
            corner.translatesAutoresizingMaskIntoConstraints = false
            soccerFieldView.addSubview(corner)
        }
        bottomLeftCornerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(lineWidth / 2)
            make.bottom.equalToSuperview().offset(-lineWidth / 2)
            make.width.equalTo(cornerWidth)
            make.height.equalTo(cornerWidth)
        }
//        for corner in cornerViews {
            let shape = CAShapeLayer()
            shape.path = returnCornerBezierPath().cgPath
            shape.strokeColor = lineColor.cgColor
            shape.fillColor = UIColor.clear.cgColor
            shape.position = CGPoint(x: 0, y: 0)
            shape.lineWidth = lineWidth
//            corner.layer.addSublayer(shape)
//        }
        bottomLeftCornerView.layer.addSublayer(shape)

    }
    
    func returnCornerBezierPath() -> UIBezierPath {
        let cornerPath = UIBezierPath()
        cornerPath.move(to: CGPoint(x: 0, y: 0))
        cornerPath.addLine(to: CGPoint(x: 0, y: cornerWidth))
        cornerPath.addLine(to: CGPoint(x: cornerWidth, y: cornerWidth))
        cornerPath.addCurve(to: CGPoint(x: 0, y: 0), controlPoint1: CGPoint(x: cornerWidth, y: cornerWidth), controlPoint2: CGPoint(x: cornerWidth, y: 0))
        cornerPath.close()
        
        return cornerPath
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

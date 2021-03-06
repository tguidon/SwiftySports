//
//  SoccerFieldView.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

class SoccerFieldView: UIView {
    
    let soccerField = SoccerField()
    
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
    private var curveViews: [UIView] = []
    
    // Colors with a redraw on set tp update view
    var fieldColor: UIColor = UIColor(red:0.55, green:0.84, blue:0.57, alpha:1.00) {
        didSet {
            self.backgroundColor = fieldColor
            draw()
        }
    }
    var lineColor: UIColor = .white {
        didSet {
            draw()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of lines
        fieldLines = [centerCircleView, midFieldLineView, homeGoalView, awayGoalView,
                      homeGoalAreaView, awayGoalAreaView, homePenaltyAreaView, awayPenaltyAreaView]
        fieldDots = [centerCircleDotView, homePenaltyDotView, awayPenaltyDotView]
        cornerViews = [topLeftCornerView, bottomLeftCornerView, topRightCornerView, bottomRightCornerView]
        curveViews = [homeAreaCurveView, awayAreaCurveView]

        self.backgroundColor = fieldColor
        self.clipsToBounds = true
    }
    
    func setup() {
        // Setup the views
        soccerFieldView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(soccerFieldView)
        fieldLines.forEach({$0.translatesAutoresizingMaskIntoConstraints = false })
        fieldLines.forEach({ soccerFieldView.addSubview($0) })
        fieldDots.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        fieldDots.forEach({ soccerFieldView.addSubview($0) })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        soccerField.initWithWidth(self.frame.width)
        draw()
    }
    
    func draw() {
        // Draw field
        soccerFieldView.backgroundColor = fieldColor
        soccerFieldView.layer.borderColor = lineColor.cgColor
        // must be set for the goals
        soccerFieldView.layer.borderWidth = soccerField.lineWidth
        soccerFieldView.clipsToBounds = false
        soccerFieldView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(soccerField.soccerFieldOffset)
            make.right.equalToSuperview().offset(-soccerField.soccerFieldOffset)
        }
        
        // Draw the lines and dots
        fieldLines.forEach({ $0.layer.borderWidth = soccerField.lineWidth })
        fieldLines.forEach({ $0.layer.borderColor = lineColor.cgColor })
        fieldLines.forEach({ $0.backgroundColor = .clear })
        fieldDots.forEach({ $0.backgroundColor = lineColor })
        
        // Draw the goals
        homeGoalView.snp.remakeConstraints { (make) in
            make.right.equalTo(soccerFieldView.snp.left).offset(soccerField.lineWidth)
            make.width.equalTo(soccerField.goalWidth)
            make.height.equalTo(soccerField.goalHeight)
            make.centerY.equalToSuperview()
        }
        awayGoalView.snp.remakeConstraints { (make) in
            make.left.equalTo(soccerFieldView.snp.right).offset(-soccerField.lineWidth)
            make.width.equalTo(soccerField.goalWidth)
            make.height.equalTo(soccerField.goalHeight)
            make.centerY.equalToSuperview()
        }
        homeGoalView.backgroundColor = fieldColor
        awayGoalView.backgroundColor = fieldColor
        
        // Draw midfield line
        midFieldLineView.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(soccerField.lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // Draw the penalty area
        homePenaltyAreaView.snp.remakeConstraints { (make) in
            make.left.equalTo(soccerFieldView.snp.left)
            make.width.equalTo(soccerField.penaltyAreaWidth)
            make.height.equalTo(soccerField.penaltyAreaHeight)
            make.centerY.equalToSuperview()
        }
        awayPenaltyAreaView.snp.remakeConstraints { (make) in
            make.right.equalTo(soccerFieldView.snp.right)
            make.width.equalTo(soccerField.penaltyAreaWidth)
            make.height.equalTo(soccerField.penaltyAreaHeight)
            make.centerY.equalToSuperview()
        }
        
        // Draw the goal area
        homeGoalAreaView.snp.remakeConstraints { (make) in
            make.left.equalTo(soccerFieldView.snp.left)
            make.width.equalTo(soccerField.goalAreaWidth)
            make.height.equalTo(soccerField.goalAreaHeight)
            make.centerY.equalToSuperview()
        }
        awayGoalAreaView.snp.remakeConstraints { (make) in
            make.right.equalTo(soccerFieldView.snp.right)
            make.width.equalTo(soccerField.goalAreaWidth)
            make.height.equalTo(soccerField.goalAreaHeight)
            make.centerY.equalToSuperview()
        }

        // Draw the penalty dots
        homePenaltyDotView.snp.remakeConstraints { (make) in
            make.width.equalTo(soccerField.centerCircleDotWidth)
            make.height.equalTo(soccerField.centerCircleDotWidth)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(soccerFieldView.snp.left).offset(soccerField.penaltyDotOffset)
        }
        awayPenaltyDotView.snp.remakeConstraints { (make) in
            make.width.equalTo(soccerField.centerCircleDotWidth)
            make.height.equalTo(soccerField.centerCircleDotWidth)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(soccerFieldView.snp.right).offset(-soccerField.penaltyDotOffset)
        }
        homePenaltyDotView.layer.cornerRadius = soccerField.centerCircleDotWidth / 2
        awayPenaltyDotView.layer.cornerRadius = soccerField.centerCircleDotWidth / 2

        
        // add the center circle and dot
        centerCircleView.snp.remakeConstraints { (make) in
            make.width.equalTo(soccerField.centerCircleWidth)
            make.height.equalTo(soccerField.centerCircleWidth)
            make.center.equalToSuperview()
        }
        centerCircleDotView.snp.remakeConstraints { (make) in
            make.width.equalTo(soccerField.centerCircleDotWidth)
            make.height.equalTo(soccerField.centerCircleDotWidth)
            make.center.equalToSuperview()
        }
        centerCircleView.layer.cornerRadius = soccerField.centerCircleWidth / 2
        centerCircleDotView.layer.cornerRadius = soccerField.centerCircleDotWidth / 2
        
        // add the corners
        for corner in cornerViews {
            corner.backgroundColor = .clear
            corner.translatesAutoresizingMaskIntoConstraints = false
            soccerFieldView.addSubview(corner)
        }
        topLeftCornerView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(soccerField.lineWidth / 2)
            make.top.equalToSuperview()
            make.width.equalTo(soccerField.cornerWidth)
            make.height.equalTo(soccerField.cornerWidth)
        }
        bottomLeftCornerView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(soccerField.lineWidth / 2)
            make.bottom.equalToSuperview()
            make.width.equalTo(soccerField.cornerWidth)
            make.height.equalTo(soccerField.cornerWidth)
        }
        topRightCornerView.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-soccerField.lineWidth / 2)
            make.top.equalToSuperview()
            make.width.equalTo(soccerField.cornerWidth)
            make.height.equalTo(soccerField.cornerWidth)
        }
        bottomRightCornerView.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-soccerField.lineWidth / 2)
            make.bottom.equalToSuperview()
            make.width.equalTo(soccerField.cornerWidth)
            make.height.equalTo(soccerField.cornerWidth)
        }
        let topLeftShape = CAShapeLayer()
        let bottomLeftShape = CAShapeLayer()
        let topRightShape = CAShapeLayer()
        let bottomRightShape = CAShapeLayer()
        let cornerShapes = [topLeftShape, bottomLeftShape, topRightShape, bottomRightShape]
        for corner in cornerShapes {
            corner.path = returnCornerBezierPath().cgPath
            corner.strokeColor = lineColor.cgColor
            corner.fillColor = UIColor.clear.cgColor
            corner.position = CGPoint(x: 0, y: 0)
            corner.lineWidth = soccerField.lineWidth
        }
        topLeftCornerView.layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        topLeftCornerView.layer.addSublayer(topLeftShape)
        bottomLeftCornerView.layer.addSublayer(bottomLeftShape)
        topRightCornerView.layer.addSublayer(topRightShape)
        bottomRightCornerView.layer.addSublayer(bottomRightShape)
        topLeftCornerView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        topRightCornerView.transform = CGAffineTransform(rotationAngle: .pi)
        bottomRightCornerView.transform = CGAffineTransform(rotationAngle: (.pi / 2) * 3)
        
        // add the curve right outside the penalty and goal
        for curve in curveViews {
            curve.backgroundColor = .clear
            curve.translatesAutoresizingMaskIntoConstraints = false
            soccerFieldView.addSubview(curve)
        }
        homeAreaCurveView.snp.remakeConstraints { (make) in
            make.width.equalTo(soccerField.areaCurveWidth)
            make.height.equalTo(soccerField.areaCurveHeight)
            make.left.equalTo(homePenaltyAreaView.snp.right).offset(-soccerField.lineWidth / 2)
            make.centerY.equalToSuperview()
        }
        awayAreaCurveView.snp.remakeConstraints { (make) in
            make.width.equalTo(soccerField.areaCurveWidth)
            make.height.equalTo(soccerField.areaCurveHeight)
            make.right.equalTo(awayPenaltyAreaView.snp.left).offset(soccerField.lineWidth / 2)
            make.centerY.equalToSuperview()
        }
        
        let homeCurveShape = CAShapeLayer()
        let awayCurveShape = CAShapeLayer()
        let curveShapes = [homeCurveShape, awayCurveShape]
        for curve in curveShapes {
            curve.path = returnGoalCurveBezierPath().cgPath
            curve.strokeColor = lineColor.cgColor
            curve.fillColor = UIColor.clear.cgColor
            curve.position = CGPoint(x: 0, y: 0)
            curve.lineWidth = soccerField.lineWidth
        }
        homeAreaCurveView.layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        homeAreaCurveView.layer.addSublayer(homeCurveShape)
        awayAreaCurveView.layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        awayAreaCurveView.layer.addSublayer(awayCurveShape)
        awayAreaCurveView.transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func returnCornerBezierPath() -> UIBezierPath {
        let cornerPath = UIBezierPath()
        let cornerWidth = soccerField.cornerWidth
        cornerPath.move(to: CGPoint(x: 1, y: 1))
        cornerPath.addLine(to: CGPoint(x: 1, y: cornerWidth - 1))
        cornerPath.addLine(to: CGPoint(x: cornerWidth - 1, y: cornerWidth - 1))
        cornerPath.addCurve(to: CGPoint(x: 1, y: 1), controlPoint1: CGPoint(x: cornerWidth - 1, y: cornerWidth - 1), controlPoint2: CGPoint(x: cornerWidth - 1, y: 1))
        cornerPath.close()
        
        return cornerPath
    }
    
    func returnGoalCurveBezierPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let areaCurveHeight = soccerField.areaCurveHeight
        let areaCurveWidth = soccerField.areaCurveWidth
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 0, y: areaCurveHeight), controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 0, y: areaCurveHeight))
        bezierPath.addCurve(to: CGPoint(x: areaCurveWidth, y: areaCurveHeight / 2), controlPoint1: CGPoint(x: 0, y: areaCurveHeight), controlPoint2: CGPoint(x: areaCurveWidth, y: areaCurveHeight * (15/18)))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 0), controlPoint1: CGPoint(x: areaCurveWidth, y: areaCurveHeight * (4/18)), controlPoint2: CGPoint(x: 0, y: 0))
        bezierPath.close()
        
        return bezierPath
    }
    
}

//
//  IceiceRinkView.swift
//  HockeyView
//
//  Created by Taylor Guidon on 1/16/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit


protocol IceRinkViewDataSource {
    func widthForRink(_ iceRinkView: IceRinkView) -> CGFloat
}

class IceRinkView: UIView {
    
    var dataSource: IceRinkViewDataSource?
    
    // Don't change these constants, used for ratios
    private let kRealRinkWidth: CGFloat = 200.0
    private let kRealRinkHeight: CGFloat = 85.0
    
    // UI
    // iceRinkView holds the rink's UI elements
    // dataView holds potential data overlays
    private let iceRinkView = UIView()
    private let dataView = UIView()
    
    // Views for rink elements
    // Lines
    private let homeGoalLine = UIView()
    private let awayGoalLine = UIView()
    private let homeBlueLine = UIView()
    private let awayBlueLine = UIView()
    
    
    // Creases
    private let homeCrease = UIView()
    private let awayCrease = UIView()
    
    // Faceoff Circles
    private let homeTopCircle = UIView()
    private let homeBottomCircle = UIView()
    private let awayTopCircle = UIView()
    private let awayBottomCircle = UIView()
    private let homeTopCircleDot = UIView()
    private let homeBottomCircleDot = UIView()
    private let awayTopCircleDot = UIView()
    private let awayBottomCircleDot = UIView()
    
    // Center Ice
    private let centerIceLine = UIView()
    private let centerIceCircle = UIView()
    private let centerIceDot = UIView()
    
    // Neutral Zone
    private let homeTopNeutralDot = UIView()
    private let homeBottomNeutralDot = UIView()
    private let awayTopNeutralDot = UIView()
    private let awayBottomNeutralDot = UIView()
    
    // View Arrays
    private var faceoffCircles: [UIView] = []
    private var faceoffCircleDots: [UIView] = []
    private var neutralZoneDots: [UIView] = []
    private var creases: [UIView] = []
    
    // VARS
    // Colors with a redraw on set tp update view
    var iceColor: UIColor = .white {
        didSet {
            drawToScale()
        }
    }
    var redLineColor: UIColor = UIColor(red:0.91, green:0.36, blue:0.45, alpha:1.00) {
        didSet {
            drawToScale()
        }
    }
    var blueLineColor: UIColor = UIColor(red:0.32, green:0.63, blue:0.82, alpha:1.00) {
        didSet {
            drawToScale()
        }
    }
    var boardColor: UIColor = UIColor(red:0.27, green:0.27, blue:0.32, alpha:1.00) {
        didSet {
            drawToScale()
        }
    }
    
    // Setup temp
    private var iceRinkViewWidth: CGFloat = 0
    private var iceRinkViewHeight: CGFloat = 0
    
    // Ratios based on real rink values
    private var rinkCornerRatio: CGFloat = 0
    private var boardWidthRatio: CGFloat = 0
    
    // UI offets
    private var goalLineOffset: CGFloat = 0
    private var blueLineOffset: CGFloat = 0
    private var neutralDotOffset: CGFloat = 0
    private var faceoffHorizontalOffset: CGFloat = 0
    private var faceoffVerticalOffset: CGFloat = 0
    
    //  UI widths
    private var boardWidth: CGFloat = 1
    private var minorLineWidth: CGFloat = 1
    private var majorLineWidth: CGFloat = 1
    private var circleWidth: CGFloat = 1
    private var dotWidth: CGFloat = 1
    private var centerDotWidth: CGFloat = 1
    private var creaseWidth: CGFloat = 1
    private var creaseHeight: CGFloat = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of similar elements
        faceoffCircles = [homeTopCircle, homeBottomCircle, awayTopCircle, awayBottomCircle, centerIceCircle]
        faceoffCircleDots = [homeTopCircleDot, homeBottomCircleDot, awayTopCircleDot, awayBottomCircleDot]
        neutralZoneDots = [homeTopNeutralDot, homeBottomNeutralDot, awayTopNeutralDot, awayBottomNeutralDot]
        creases = [homeCrease, awayCrease]
        
        self.backgroundColor = .clear
        
        // need constants set up before you can draw
        setupConstants()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Give the rink it's corners and scaled border
        iceRinkView.layer.cornerRadius = iceRinkView.bounds.width * rinkCornerRatio
        iceRinkView.layer.borderWidth = iceRinkView.bounds.width * boardWidthRatio
    }
    
    func drawRink() {
        // Draw the base rink with border for bords
        iceRinkView.backgroundColor = iceColor
        iceRinkView.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.layer.borderColor = boardColor.cgColor
        iceRinkView.clipsToBounds = true
        self.addSubview(iceRinkView)
        
        iceRinkView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalToSuperview()
        }
        
        
        // Add the two goal lines
        homeGoalLine.backgroundColor = redLineColor
        homeGoalLine.translatesAutoresizingMaskIntoConstraints = false
        awayGoalLine.backgroundColor = redLineColor
        awayGoalLine.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.addSubview(homeGoalLine)
        iceRinkView.addSubview(awayGoalLine)
        
        homeGoalLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(minorLineWidth)
            make.centerX.equalTo(self.snp.left).offset(goalLineOffset)
        }
        awayGoalLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(minorLineWidth)
            make.centerX.equalTo(self.snp.right).offset(-goalLineOffset)
        }
        
        
        // Add the blue lines and red line
        homeBlueLine.backgroundColor = blueLineColor
        awayBlueLine.backgroundColor = blueLineColor
        centerIceLine.backgroundColor = redLineColor
        homeBlueLine.translatesAutoresizingMaskIntoConstraints = false
        awayBlueLine.translatesAutoresizingMaskIntoConstraints = false
        centerIceLine.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.addSubview(homeBlueLine)
        iceRinkView.addSubview(awayBlueLine)
        iceRinkView.addSubview(centerIceLine)
        
        homeBlueLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(blueLineOffset)
        }
        awayBlueLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-blueLineOffset)
        }
        centerIceLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalToSuperview()
        }
        centerIceLine.layer.zPosition = 100
        
        
        // Add all of the faceoff circles
        for circle in faceoffCircles {
            circle.backgroundColor = iceColor
            circle.layer.borderColor = redLineColor.cgColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            
            circle.layer.cornerRadius = circleWidth / 2
            circle.layer.borderWidth = minorLineWidth
            
            iceRinkView.addSubview(circle)
        }
        homeTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(faceoffVerticalOffset)
        }
        homeBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-faceoffVerticalOffset)
        }
        awayTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(faceoffVerticalOffset)
        }
        awayBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-faceoffVerticalOffset)
        }
        centerIceCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.center.equalToSuperview()
        }
        centerIceCircle.layer.borderColor = blueLineColor.cgColor
        
        
        // Add the dashes to the faceoff circles
        for index in 0...3 {
            let leftLine = UIView()
            let rightLine = UIView()
            let lines: [UIView] = [leftLine, rightLine]
            for line in lines {
                line.backgroundColor = redLineColor
                line.translatesAutoresizingMaskIntoConstraints = false
                faceoffCircles[index].addSubview(line)
            }
            leftLine.snp.makeConstraints({ (make) in
                make.height.equalToSuperview().multipliedBy(1.2)
                make.width.equalTo(minorLineWidth)
                make.centerX.equalToSuperview().offset(-5)
                make.centerY.equalToSuperview()
            })
            rightLine.snp.makeConstraints({ (make) in
                make.height.equalToSuperview().multipliedBy(1.2)
                make.width.equalTo(minorLineWidth)
                make.centerX.equalToSuperview().offset(5)
                make.centerY.equalToSuperview()
            })
        }
        
        
        // Mask the lines with a view, I was lazy here and couldnt get a proper mask layer to work
        for index in 0...3 {
            let v = UIView()
            v.backgroundColor = iceColor
            v.translatesAutoresizingMaskIntoConstraints = false
            faceoffCircles[index].addSubview(v)
            
            v.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            })
            v.layer.cornerRadius = circleWidth / 2
        }
        
        
        // Add the faceoff dots to the circles
        // go to index of 3 to skip center ice, its a smaller dot there
        for index in 0...3 {
            faceoffCircleDots[index].backgroundColor = redLineColor
            faceoffCircleDots[index].translatesAutoresizingMaskIntoConstraints = false
            faceoffCircles[index].addSubview(faceoffCircleDots[index])
            
            faceoffCircleDots[index].snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(dotWidth)
                make.height.equalTo(dotWidth)
            }
            faceoffCircleDots[index].layer.cornerRadius = dotWidth / 2
        }
        
        
        // Add center ice dot
        centerIceDot.backgroundColor = blueLineColor
        centerIceDot.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.addSubview(centerIceDot)
        centerIceDot.snp.makeConstraints { (make) in
            make.height.equalTo(centerDotWidth)
            make.width.equalTo(centerDotWidth)
            make.center.equalToSuperview()
        }
        // puts it above the red line
        centerIceDot.layer.zPosition = 101
        centerIceDot.layer.cornerRadius = centerDotWidth / 2
        
        
        // Add the neutral zone dots
        for dot in neutralZoneDots {
            dot.backgroundColor = redLineColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            iceRinkView.addSubview(dot)
        }
        homeTopNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        homeBottomNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        awayTopNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        awayBottomNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        for dot in neutralZoneDots {
            dot.layer.cornerRadius = dotWidth / 2
        }
        
        
        // Add the two goal creases
        for crease in creases {
            crease.backgroundColor = UIColor.clear
            crease.translatesAutoresizingMaskIntoConstraints = false
            iceRinkView.addSubview(crease)
        }
        homeCrease.snp.makeConstraints { (make) in
            make.height.equalTo(creaseHeight)
            make.width.equalTo(creaseWidth)
            make.centerY.equalToSuperview()
            make.left.equalTo(homeGoalLine.snp.right).offset(-minorLineWidth * 0.5)
        }
        awayCrease.snp.makeConstraints { (make) in
            make.height.equalTo(creaseHeight)
            make.width.equalTo(creaseWidth)
            make.centerY.equalToSuperview()
            make.right.equalTo(awayGoalLine.snp.left).offset(minorLineWidth * 0.5)
        }
        let homeGoalShapeLayer = CAShapeLayer()
        let awayGoalShapeLayer = CAShapeLayer()
        let goalShapeLayers: [CAShapeLayer] = [homeGoalShapeLayer, awayGoalShapeLayer]
        for goal in goalShapeLayers {
            // Bezier path to get that curve on the crease
            goal.path = returnGoalBezierPath().cgPath
            goal.strokeColor = redLineColor.cgColor
            goal.fillColor = UIColor.blue.withAlphaComponent(0.2).cgColor
            goal.position = CGPoint(x: 0, y: 0)
            goal.lineWidth = minorLineWidth * 0.5
        }
        homeCrease.layer.addSublayer(homeGoalShapeLayer)
        awayCrease.layer.addSublayer(awayGoalShapeLayer)
        awayCrease.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
    }
    
    func drawToScale() {
        guard let width = dataSource?.widthForRink(self) else {
            print("No width set in dataSource")
            return
        }
        
        iceRinkViewWidth = width
        setupConstants()
        drawRink()
    }
    
    func returnGoalBezierPath() -> UIBezierPath {
        let goalPath = UIBezierPath()
        goalPath.move(to: CGPoint(x: 0, y: 0))
        goalPath.addLine(to: CGPoint(x: creaseWidth * (2/3), y: 0))
        goalPath.addCurve(to: CGPoint(x: creaseWidth, y: creaseHeight / 2), controlPoint1: CGPoint(x: creaseWidth * (2/3), y: 0), controlPoint2: CGPoint(x: creaseWidth, y: creaseHeight * (1/4)))
        goalPath.addCurve(to: CGPoint(x: creaseWidth * (2/3), y: creaseHeight), controlPoint1: CGPoint(x: creaseWidth, y: creaseHeight * (3/4)), controlPoint2: CGPoint(x: creaseWidth * (2/3), y: creaseHeight))
        goalPath.addCurve(to: CGPoint(x: 0, y: creaseHeight), controlPoint1: CGPoint(x: creaseWidth / 2, y: creaseHeight), controlPoint2: CGPoint(x: 0, y: creaseHeight))
        goalPath.addLine(to: CGPoint(x: 0, y: 0))
        goalPath.close()
        
        return goalPath
    }
    
    func setupConstants() {
        iceRinkViewHeight = iceRinkViewWidth * (17 / 40)
        
        rinkCornerRatio = 28.0 / kRealRinkWidth
        boardWidthRatio = 1.5 / kRealRinkWidth
        
        let minorLineWidthRatio: CGFloat = 1.0 / kRealRinkWidth
        let majorLineWidthRatio: CGFloat = 2.0 / kRealRinkWidth
        minorLineWidth = iceRinkViewWidth * minorLineWidthRatio
        majorLineWidth = iceRinkViewWidth * majorLineWidthRatio
        
        let goalLineOffsetRatio: CGFloat = 11 / kRealRinkWidth
        goalLineOffset = iceRinkViewWidth * goalLineOffsetRatio
        
        let blueLineOffsetRatio: CGFloat = 64 / kRealRinkWidth
        blueLineOffset = iceRinkViewWidth * blueLineOffsetRatio
        
        let neutralDotRatio: CGFloat = 5 / kRealRinkWidth
        neutralDotOffset = iceRinkViewWidth * neutralDotRatio
        
        let circleSizeRatio: CGFloat = 30 / kRealRinkWidth
        circleWidth = iceRinkViewWidth * circleSizeRatio
        
        let dotSizeRatio: CGFloat = 2.5 / kRealRinkWidth
        dotWidth = iceRinkViewWidth * dotSizeRatio
        
        let centerDotSizeRatio: CGFloat = 1.5 / kRealRinkWidth
        centerDotWidth = iceRinkViewWidth * centerDotSizeRatio
        
        let faceoffCircleRatio: CGFloat = 22 / kRealRinkWidth
        let faceOffGapRatio: CGFloat = 44 / kRealRinkHeight
        faceoffHorizontalOffset = iceRinkViewWidth * faceoffCircleRatio
        faceoffVerticalOffset = (iceRinkViewHeight * faceOffGapRatio) / 2
        
        let creaseWidthRatio: CGFloat = 6 / kRealRinkWidth
        let creaseHeightRatio: CGFloat = 8 / kRealRinkHeight
        creaseWidth = iceRinkViewWidth * creaseWidthRatio
        creaseHeight = iceRinkViewHeight * creaseHeightRatio
    }
}

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
    let iceRink = IceRink()

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
    

    // Colors with a redraw on set to update view
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
    var boardColor: UIColor = UIColor(red:0.32, green:0.63, blue:0.82, alpha:1.00) {
        didSet {
            drawToScale()
        }
    }
    var creaseColor: UIColor = UIColor.blue.withAlphaComponent(0.2) {
        didSet {
            drawToScale()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of similar elements
        faceoffCircles = [homeTopCircle, homeBottomCircle, awayTopCircle, awayBottomCircle, centerIceCircle]
        faceoffCircleDots = [homeTopCircleDot, homeBottomCircleDot, awayTopCircleDot, awayBottomCircleDot]
        neutralZoneDots = [homeTopNeutralDot, homeBottomNeutralDot, awayTopNeutralDot, awayBottomNeutralDot]
        creases = [homeCrease, awayCrease]
        
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Give the rink it's corners and scaled border
        iceRinkView.layer.cornerRadius = iceRinkView.bounds.width * iceRink.rinkCornerRatio
        iceRinkView.layer.borderWidth = iceRinkView.bounds.width * iceRink.boardWidthRatio
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
            make.width.equalTo(iceRink.minorLineWidth)
            make.centerX.equalTo(self.snp.left).offset(iceRink.goalLineOffset)
        }
        awayGoalLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.minorLineWidth)
            make.centerX.equalTo(self.snp.right).offset(-iceRink.goalLineOffset)
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
            make.width.equalTo(iceRink.majorLineWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(iceRink.blueLineOffset)
        }
        awayBlueLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.majorLineWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-iceRink.blueLineOffset)
        }
        centerIceLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.majorLineWidth)
            make.centerX.equalToSuperview()
        }
        centerIceLine.layer.zPosition = 100
        
        
        // Add all of the faceoff circles
        for circle in faceoffCircles {
            circle.backgroundColor = iceColor
            circle.layer.borderColor = redLineColor.cgColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            
            circle.layer.cornerRadius = iceRink.circleWidth / 2
            circle.layer.borderWidth = iceRink.minorLineWidth
            
            iceRinkView.addSubview(circle)
        }
        homeTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(iceRink.faceoffVerticalOffset)
        }
        homeBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-iceRink.faceoffVerticalOffset)
            make.centerY.equalTo(self.snp.bottom)
        }
        awayTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(iceRink.faceoffVerticalOffset)
        }
        awayBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-iceRink.faceoffVerticalOffset)
        }
        centerIceCircle.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
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
                make.width.equalTo(iceRink.minorLineWidth)
                make.centerX.equalToSuperview().offset(-5)
                make.centerY.equalToSuperview()
            })
            rightLine.snp.makeConstraints({ (make) in
                make.height.equalToSuperview().multipliedBy(1.2)
                make.width.equalTo(iceRink.minorLineWidth)
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
            v.layer.cornerRadius = iceRink.circleWidth / 2
        }
        
        
        // Add the faceoff dots to the circles
        // go to index of 3 to skip center ice, its a smaller dot there
        for index in 0...3 {
            faceoffCircleDots[index].backgroundColor = redLineColor
            faceoffCircleDots[index].translatesAutoresizingMaskIntoConstraints = false
            faceoffCircles[index].addSubview(faceoffCircleDots[index])
            
            faceoffCircleDots[index].snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(iceRink.dotWidth)
                make.height.equalTo(iceRink.dotWidth)
            }
            faceoffCircleDots[index].layer.cornerRadius = iceRink.dotWidth / 2
        }
        
        
        // Add center ice dot
        centerIceDot.backgroundColor = blueLineColor
        centerIceDot.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.addSubview(centerIceDot)
        centerIceDot.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.centerDotWidth)
            make.width.equalTo(iceRink.centerDotWidth)
            make.center.equalToSuperview()
        }
        // puts it above the red line
        centerIceDot.layer.zPosition = 101
        centerIceDot.layer.cornerRadius = iceRink.centerDotWidth / 2
        
        
        // Add the neutral zone dots
        for dot in neutralZoneDots {
            dot.backgroundColor = redLineColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            iceRinkView.addSubview(dot)
        }
        homeTopNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(iceRink.neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        homeBottomNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(iceRink.neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        awayTopNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-iceRink.neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        awayBottomNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-iceRink.neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        for dot in neutralZoneDots {
            dot.layer.cornerRadius = iceRink.dotWidth / 2
        }
        
        
        // Add the two goal creases
        for crease in creases {
            crease.backgroundColor = UIColor.clear
            crease.translatesAutoresizingMaskIntoConstraints = false
            iceRinkView.addSubview(crease)
        }
        homeCrease.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.creaseHeight)
            make.width.equalTo(iceRink.creaseWidth)
            make.centerY.equalToSuperview()
            make.left.equalTo(homeGoalLine.snp.right).offset(-iceRink.minorLineWidth * 0.5)
        }
        awayCrease.snp.makeConstraints { (make) in
            make.height.equalTo(iceRink.creaseHeight)
            make.width.equalTo(iceRink.creaseWidth)
            make.centerY.equalToSuperview()
            make.right.equalTo(awayGoalLine.snp.left).offset(iceRink.minorLineWidth * 0.5)
        }
        let homeGoalShapeLayer = CAShapeLayer()
        let awayGoalShapeLayer = CAShapeLayer()
        let goalShapeLayers: [CAShapeLayer] = [homeGoalShapeLayer, awayGoalShapeLayer]
        for goal in goalShapeLayers {
            // Bezier path to get that curve on the crease
            goal.path = returnGoalBezierPath().cgPath
            goal.strokeColor = redLineColor.cgColor
            goal.fillColor = creaseColor.cgColor
            goal.position = CGPoint(x: 0, y: 0)
            goal.lineWidth = iceRink.minorLineWidth * 0.5
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
        
        iceRink.initWithWidth(width)
        drawRink()
    }
    
    func returnGoalBezierPath() -> UIBezierPath {
        let goalPath = UIBezierPath()
        let creaseWidth = iceRink.creaseWidth
        let creaseHeight = iceRink.creaseHeight
        goalPath.move(to: CGPoint(x: 0, y: 0))
        goalPath.addLine(to: CGPoint(x: creaseWidth * (2/3), y: 0))
        goalPath.addCurve(to: CGPoint(x: creaseWidth, y: creaseHeight / 2), controlPoint1: CGPoint(x: creaseWidth * (2/3), y: 0), controlPoint2: CGPoint(x: creaseWidth, y: creaseHeight * (1/4)))
        goalPath.addCurve(to: CGPoint(x: creaseWidth * (2/3), y: creaseHeight), controlPoint1: CGPoint(x: creaseWidth, y: creaseHeight * (3/4)), controlPoint2: CGPoint(x: creaseWidth * (2/3), y: creaseHeight))
        goalPath.addCurve(to: CGPoint(x: 0, y: creaseHeight), controlPoint1: CGPoint(x: creaseWidth / 2, y: creaseHeight), controlPoint2: CGPoint(x: 0, y: creaseHeight))
        goalPath.addLine(to: CGPoint(x: 0, y: 0))
        goalPath.close()
        
        return goalPath
    }
}

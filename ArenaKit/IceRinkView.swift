//
//  IceiceRinkView.swift
//  HockeyView
//
//  Created by Taylor Guidon on 1/16/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

class IceRinkView: UIView {
    
    let iceRink = IceRink()
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
    private var goalLines: [UIView] = []
    private var blueLines: [UIView] = []
    private var faceoffCircles: [UIView] = []
    private var faceoffCircleDots: [UIView] = []
    private var neutralZoneDots: [UIView] = []
    private var creases: [UIView] = []
    

    // Colors with a redraw on set to update view
    var iceColor: UIColor = .white {
        didSet {
            draw()
        }
    }
    var redLineColor: UIColor = UIColor(red:0.91, green:0.36, blue:0.45, alpha:1.00) {
        didSet {
            draw()
        }
    }
    var blueLineColor: UIColor = UIColor(red:0.32, green:0.63, blue:0.82, alpha:1.00) {
        didSet {
            draw()
        }
    }
    var boardColor: UIColor = UIColor(red:0.32, green:0.63, blue:0.82, alpha:1.00) {
        didSet {
            draw()
        }
    }
    var creaseColor: UIColor = UIColor.blue.withAlphaComponent(0.2) {
        didSet {
            draw()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of similar elements
        goalLines = [homeGoalLine, awayGoalLine]
        blueLines = [homeBlueLine, awayBlueLine]
        faceoffCircles = [homeTopCircle, homeBottomCircle, awayTopCircle, awayBottomCircle, centerIceCircle]
        faceoffCircleDots = [homeTopCircleDot, homeBottomCircleDot, awayTopCircleDot, awayBottomCircleDot]
        neutralZoneDots = [homeTopNeutralDot, homeBottomNeutralDot, awayTopNeutralDot, awayBottomNeutralDot]
        creases = [homeCrease, awayCrease]
        
        self.backgroundColor = .clear
    }
    
    func setup() {
        iceRinkView.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.clipsToBounds = true
        self.addSubview(iceRinkView)
        goalLines.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        goalLines.forEach({ iceRinkView.addSubview($0) })
        blueLines.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        blueLines.forEach({ iceRinkView.addSubview($0) })
        centerIceLine.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.addSubview(centerIceLine)
        faceoffCircles.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        faceoffCircles.forEach({ iceRinkView.addSubview($0) })
        faceoffCircleDots.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        faceoffCircleDots.forEach({ $0.layer.zPosition = 200 })
        for index in 0...3 {
            faceoffCircles[index].addSubview(faceoffCircleDots[index])
        }
        centerIceDot.translatesAutoresizingMaskIntoConstraints = false
        iceRinkView.addSubview(centerIceDot)
        neutralZoneDots.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        neutralZoneDots.forEach({ iceRinkView.addSubview($0) })
        creases.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        creases.forEach({ iceRinkView.addSubview($0) })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iceRink.initWithWidth(self.frame.width)
        // Give the rink it's corners and scaled border
        draw()
        iceRinkView.layer.cornerRadius = self.frame.width * iceRink.rinkCornerRatio
        iceRinkView.layer.borderWidth = self.frame.width * iceRink.boardWidthRatio
    }
    
    func draw() {
        // Draw the base rink with border for bords
        iceRinkView.backgroundColor = iceColor
        iceRinkView.layer.borderColor = boardColor.cgColor
        iceRinkView.snp.remakeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalToSuperview()
        }
        
        // Draw the two goal lines
        goalLines.forEach({ $0.backgroundColor = redLineColor })
        homeGoalLine.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.minorLineWidth)
            make.centerX.equalTo(self.snp.left).offset(iceRink.goalLineOffset)
        }
        awayGoalLine.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.minorLineWidth)
            make.centerX.equalTo(self.snp.right).offset(-iceRink.goalLineOffset)
        }
        
        // Draw the blue lines and red line
        blueLines.forEach({ $0.backgroundColor = blueLineColor })
        homeBlueLine.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.majorLineWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(iceRink.blueLineOffset)
        }
        awayBlueLine.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.majorLineWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-iceRink.blueLineOffset)
        }
        
        // Draw the center ice line
        centerIceLine.backgroundColor = redLineColor
        centerIceLine.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(iceRink.majorLineWidth)
            make.centerX.equalToSuperview()
        }
        centerIceLine.layer.zPosition = 100
        
        // Draw the faceoff circles
        faceoffCircles.forEach({ $0.backgroundColor = iceColor })
        faceoffCircles.forEach({ $0.layer.borderColor = redLineColor.cgColor })
        faceoffCircles.forEach({ $0.layer.cornerRadius = iceRink.circleWidth / 2 })
        faceoffCircles.forEach({ $0.layer.borderWidth = iceRink.minorLineWidth })
        homeTopCircle.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(iceRink.faceoffVerticalOffset)
        }
        homeBottomCircle.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-iceRink.faceoffVerticalOffset)
        }
        awayTopCircle.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(iceRink.faceoffVerticalOffset)
        }
        awayBottomCircle.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-iceRink.faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-iceRink.faceoffVerticalOffset)
        }
        centerIceCircle.layer.borderColor = blueLineColor.cgColor
        centerIceCircle.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.circleWidth)
            make.width.equalTo(iceRink.circleWidth)
            make.center.equalToSuperview()
        }
        
        // Draw the dashes to the faceoff circles
        for index in 0...3 {
            let leftLine = UIView()
            let rightLine = UIView()
            let lines: [UIView] = [leftLine, rightLine]
            for line in lines {
                line.backgroundColor = redLineColor
                line.translatesAutoresizingMaskIntoConstraints = false
                faceoffCircles[index].addSubview(line)
            }
            leftLine.snp.remakeConstraints({ (make) in
                make.height.equalToSuperview().multipliedBy(1.2)
                make.width.equalTo(iceRink.minorLineWidth)
                make.centerX.equalToSuperview().offset(-5)
                make.centerY.equalToSuperview()
            })
            rightLine.snp.remakeConstraints({ (make) in
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
            
            v.snp.remakeConstraints({ (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            })
            v.layer.cornerRadius = iceRink.circleWidth / 2
        }
        
        // Draw the faceoff dots to the circles
        // go to index of 3 to skip center ice, its a smaller dot there
        faceoffCircleDots.forEach({ $0.backgroundColor = redLineColor })
        for index in 0...3 {
            faceoffCircleDots[index].snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(iceRink.dotWidth)
                make.height.equalTo(iceRink.dotWidth)
            }
            faceoffCircleDots[index].layer.cornerRadius = iceRink.dotWidth / 2
        }
        
        // Draw center ice dot
        centerIceDot.backgroundColor = blueLineColor
        centerIceDot.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.centerDotWidth)
            make.width.equalTo(iceRink.centerDotWidth)
            make.center.equalToSuperview()
        }
        centerIceDot.layer.zPosition = 101
        centerIceDot.layer.cornerRadius = iceRink.centerDotWidth / 2
        
        // Draw the neutral zone dots
        neutralZoneDots.forEach({ $0.backgroundColor = redLineColor })
        for dot in neutralZoneDots {
            dot.layer.cornerRadius = iceRink.dotWidth / 2
        }
        homeTopNeutralDot.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(iceRink.neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        homeBottomNeutralDot.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(iceRink.neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        awayTopNeutralDot.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-iceRink.neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        awayBottomNeutralDot.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.dotWidth)
            make.width.equalTo(iceRink.dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-iceRink.neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        
        // Draw the crease
        creases.forEach({ $0.backgroundColor = .clear })
        homeCrease.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.creaseHeight)
            make.width.equalTo(iceRink.creaseWidth)
            make.centerY.equalToSuperview()
            make.left.equalTo(homeGoalLine.snp.right).offset(-iceRink.minorLineWidth * 0.5)
        }
        awayCrease.snp.remakeConstraints { (make) in
            make.height.equalTo(iceRink.creaseHeight)
            make.width.equalTo(iceRink.creaseWidth)
            make.centerY.equalToSuperview()
            make.right.equalTo(awayGoalLine.snp.left).offset(iceRink.minorLineWidth * 0.5)
        }
        
        // Crease
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
        awayCrease.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
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

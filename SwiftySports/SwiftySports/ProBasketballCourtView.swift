//
//  ProBasketballCourtView.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/20/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

protocol ProBasketballCourtViewDataSource {
    func widthForProCourt(_ proBasketballCourtView: ProBasketballCourtView) -> CGFloat
}

class ProBasketballCourtView: UIView {
    
    var dataSource: ProBasketballCourtViewDataSource?

    // Don't change these constants, used for ratios
    private let kRealCourtWidth: CGFloat = 94.0
    private let kRealCourtHeight: CGFloat = 50.0
    
    // I dont know the rules of basketball and what the different areas
    // on the court are called. If you're a basketball fan I apologize 🙃
    
    // UI
    // proBasketballCourtView holds the court's UI elements
    // dataView holds potential data overlays
    private let proBasketballCourtView = UIView()
    private let dataView = UIView()
    
    private let homeView = UIView()
    private let awayView = UIView()
    
    // home court
    private let homeSmallBoxView = UIView()
    private let homeLargeBoxView = UIView()
    private let homeCircleView = UIView()
    private let homeBackboardView = UIView()
    private let homeHoopView = UIView()
    private let homeTopBoxHashmarkView = UIView()
    private let homeBottomBoxHashmarkView = UIView()
    
    // away court
    private let awaySmallBoxView = UIView()
    private let awayLargeBoxView = UIView()
    private let awayCircleView = UIView()
    private let awayBackboardView = UIView()
    private let awayHoopView = UIView()
    private let awayTopBoxHashmarkView = UIView()
    private let awayBottomBoxHashmarkView = UIView()
    
    // hash
    private let topLeftHashMarkView = UIView()
    private let bottomLeftHashMarkView = UIView()
    private let topRightHashMarkView = UIView()
    private let bottomRightHashMarkView = UIView()
    
    private let halfCourtLineView = UIView()
    private let halfCourtSmallCircleView = UIView()
    private let halfCourtLargeCircleView = UIView()
    
    private var hashMarkLines: [UIView] = []
    private var halfCourtLines: [UIView] = []
    private var homeCourtLines: [UIView] = []
    private var homeCourtHashMarks: [UIView] = []
    private var awayCourtLines: [UIView] = []
    private var awayCourtHashMarks: [UIView] = []
    
    
    // colors
    var courtColor: UIColor = UIColor(red:0.81, green:0.62, blue:0.54, alpha:1.00) {
        didSet {
            drawToScale()
        }
    }
    var lineColor: UIColor = .white {
        didSet {
            drawToScale()
        }
    }
    var centerCircleColor: UIColor = .purple {
        didSet {
            drawToScale()
        }
    }
    var boxColor: UIColor = .blue {
        didSet {
            drawToScale()
        }
    }
    
    // temp w and h
    private var courtViewWidth: CGFloat = 0
    private var courtViewHeight: CGFloat = 0
    
    private var lineWidth: CGFloat = 0
    private var smallCircleWidth: CGFloat = 0
    private var largeCircleWidth: CGFloat = 0
    private var hashMarkHeight: CGFloat = 0
    private var homeAwayViewWidth: CGFloat = 0
    private var homeAwayViewHeight: CGFloat = 0
    private var homeAwayStraightLineWidth: CGFloat = 0
    private var boxWidth: CGFloat = 0
    private var smallBoxHeight: CGFloat = 0
    private var largeBoxHeight: CGFloat = 0
    private var hoopWidth: CGFloat = 0
    private var backboardHeight: CGFloat = 0
    
    private var hashMarkOffset: CGFloat = 0
    private var backboardOffset: CGFloat = 0
    private var boxHashOffset: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        hashMarkLines = [topLeftHashMarkView, bottomLeftHashMarkView, topRightHashMarkView, bottomRightHashMarkView]
        halfCourtLines = [halfCourtLineView, halfCourtSmallCircleView, halfCourtLargeCircleView]
        homeCourtLines = [homeSmallBoxView, homeLargeBoxView, homeBackboardView, homeHoopView, homeCircleView]
        homeCourtHashMarks = [homeTopBoxHashmarkView, homeBottomBoxHashmarkView]
        awayCourtLines = [awaySmallBoxView, awayLargeBoxView, awayBackboardView, awayHoopView, awayCircleView]
        awayCourtHashMarks = [awayTopBoxHashmarkView, awayBottomBoxHashmarkView]
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        setupConstants()
    }
    
    func setupConstants() {
        courtViewHeight = courtViewWidth * (25 / 47)
        
        // .85
        let lineWidthRatio: CGFloat = 0.65 / kRealCourtWidth
        lineWidth = courtViewWidth * lineWidthRatio
        
        let smallCircleWidthRatio: CGFloat = 4 / kRealCourtWidth
        smallCircleWidth = courtViewWidth * smallCircleWidthRatio
        let largeCircleWidthRatio: CGFloat = 12 / kRealCourtWidth
        largeCircleWidth = courtViewWidth * largeCircleWidthRatio
        
        let hashMarkHeightRatio: CGFloat = 2.5 / kRealCourtHeight
        hashMarkHeight = courtViewHeight * hashMarkHeightRatio
        
        let hashMarkOffsetRatio: CGFloat = 28 / kRealCourtWidth
        hashMarkOffset = courtViewWidth * hashMarkOffsetRatio
        
        // 29
        let homeAwayViewWidthRatio: CGFloat = 29 / kRealCourtWidth
        homeAwayViewWidth = courtViewWidth * homeAwayViewWidthRatio
        let homeAwayViewHeightRatio: CGFloat = 44 / kRealCourtHeight
        homeAwayViewHeight = courtViewHeight * homeAwayViewHeightRatio
        let homeAwayStraightLineWidthRatio: CGFloat = 14 / kRealCourtWidth
        homeAwayStraightLineWidth = courtViewWidth * homeAwayStraightLineWidthRatio
        
        let boxWidthRatio: CGFloat = 19 / kRealCourtWidth
        boxWidth = courtViewWidth * boxWidthRatio
        let smallBoxHeightRatio: CGFloat = 12 / kRealCourtHeight
        smallBoxHeight = courtViewHeight * smallBoxHeightRatio
        let largeBoxHeightRatio: CGFloat = 16 / kRealCourtHeight
        largeBoxHeight = courtViewHeight * largeBoxHeightRatio
        
        let backboardOffsetRatio: CGFloat = 4 / kRealCourtWidth
        backboardOffset = courtViewWidth * backboardOffsetRatio
        let boxHashOffsetRatio: CGFloat = 3 / kRealCourtWidth
        boxHashOffset = courtViewWidth * boxHashOffsetRatio
        
        let hoopWidthRatio: CGFloat = 2 / kRealCourtWidth
        hoopWidth = courtViewWidth * hoopWidthRatio
        let backboardHeightRatio: CGFloat = 6 / kRealCourtHeight
        backboardHeight = courtViewHeight * backboardHeightRatio
    }
    
    func drawCourt() {
        proBasketballCourtView.backgroundColor = courtColor
        proBasketballCourtView.translatesAutoresizingMaskIntoConstraints = false
        proBasketballCourtView.layer.borderColor = lineColor.cgColor
        proBasketballCourtView.layer.borderWidth = lineWidth
        self.addSubview(proBasketballCourtView)
        proBasketballCourtView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalToSuperview()
        }
        
        // add the hashmarks
        for hashMark in hashMarkLines {
            hashMark.backgroundColor = lineColor
            hashMark.translatesAutoresizingMaskIntoConstraints = false
            proBasketballCourtView.addSubview(hashMark)
        }
        topLeftHashMarkView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(hashMarkHeight)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(hashMarkOffset)
        }
        bottomLeftHashMarkView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(hashMarkHeight)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(hashMarkOffset)
        }
        topRightHashMarkView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(hashMarkHeight)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-hashMarkOffset)
        }
        bottomRightHashMarkView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(hashMarkHeight)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-hashMarkOffset)
        }
        
        // add the half court line and circles
        for line in halfCourtLines {
            line.backgroundColor = .clear
            line.translatesAutoresizingMaskIntoConstraints = false
            line.layer.borderColor = lineColor.cgColor
            line.layer.borderWidth = lineWidth
            proBasketballCourtView.addSubview(line)
        }
        halfCourtLineView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        halfCourtSmallCircleView.snp.makeConstraints { (make) in
            make.width.equalTo(smallCircleWidth)
            make.height.equalTo(smallCircleWidth)
            make.center.equalToSuperview()
        }
        halfCourtLargeCircleView.snp.makeConstraints { (make) in
            make.width.equalTo(largeCircleWidth)
            make.height.equalTo(largeCircleWidth)
            make.center.equalToSuperview()
        }
        halfCourtSmallCircleView.layer.cornerRadius = smallCircleWidth / 2
        halfCourtLargeCircleView.layer.cornerRadius = largeCircleWidth / 2
        
        
        // add the home and away court
        homeView.backgroundColor = .clear
        homeView.translatesAutoresizingMaskIntoConstraints = false
        proBasketballCourtView.addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(homeAwayViewWidth)
            make.height.equalTo(homeAwayViewHeight)
        }
        let homeShape = CAShapeLayer()
        homeShape.path = returnHomeAreaBezierPath().cgPath
        homeShape.strokeColor = lineColor.cgColor
        homeShape.fillColor = UIColor.clear.cgColor
        homeShape.position = CGPoint(x: 0, y: 0)
        homeShape.lineWidth = lineWidth
        homeView.layer.addSublayer(homeShape)
        
        awayView.backgroundColor = .clear
        awayView.translatesAutoresizingMaskIntoConstraints = false
        proBasketballCourtView.addSubview(awayView)
        awayView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(homeAwayViewWidth)
            make.height.equalTo(homeAwayViewHeight)
        }
        let awayShape = CAShapeLayer()
        awayShape.path = returnAwayAreaBezierPath().cgPath
        awayShape.strokeColor = lineColor.cgColor
        awayShape.fillColor = UIColor.clear.cgColor
        awayShape.position = CGPoint(x: 0.5, y: 0.5)
        awayShape.lineWidth = lineWidth
        awayView.layer.addSublayer(awayShape)
        
        // add all lines
        for line in homeCourtLines {
            line.backgroundColor = .clear
            line.translatesAutoresizingMaskIntoConstraints = false
            line.layer.borderColor = lineColor.cgColor
            line.layer.borderWidth = lineWidth
            homeView.addSubview(line)
        }
        for line in awayCourtLines {
            line.backgroundColor = .clear
            line.translatesAutoresizingMaskIntoConstraints = false
            line.layer.borderColor = lineColor.cgColor
            line.layer.borderWidth = lineWidth
            awayView.addSubview(line)
        }
        
        // boxes
        homeLargeBoxView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(boxWidth)
            make.height.equalTo(largeBoxHeight)
        }
        homeSmallBoxView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(boxWidth)
            make.height.equalTo(smallBoxHeight)
        }
        awayLargeBoxView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(boxWidth)
            make.height.equalTo(largeBoxHeight)
        }
        awaySmallBoxView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(boxWidth)
            make.height.equalTo(smallBoxHeight)
        }
        
        // hashmarks
        for hash in homeCourtHashMarks {
            hash.backgroundColor = .clear
            hash.translatesAutoresizingMaskIntoConstraints = false
            homeView.addSubview(hash)
        }
        for hash in awayCourtHashMarks {
            hash.backgroundColor = .clear
            hash.translatesAutoresizingMaskIntoConstraints = false
            awayView.addSubview(hash)
        }
        homeTopBoxHashmarkView.snp.makeConstraints { (make) in
            make.left.equalTo(homeLargeBoxView.snp.left)
            make.bottom.equalTo(homeLargeBoxView.snp.top)
            make.width.equalTo(homeLargeBoxView.snp.width)
            make.height.equalTo(hashMarkHeight / 2)
        }
        homeBottomBoxHashmarkView.snp.makeConstraints { (make) in
            make.left.equalTo(homeLargeBoxView.snp.left)
            make.top.equalTo(homeLargeBoxView.snp.bottom)
            make.width.equalTo(homeLargeBoxView.snp.width)
            make.height.equalTo(hashMarkHeight / 2)
        }
        awayTopBoxHashmarkView.snp.makeConstraints { (make) in
            make.left.equalTo(awayLargeBoxView.snp.left)
            make.bottom.equalTo(awayLargeBoxView.snp.top)
            make.width.equalTo(awayLargeBoxView.snp.width)
            make.height.equalTo(hashMarkHeight / 2)
        }
        awayBottomBoxHashmarkView.snp.makeConstraints { (make) in
            make.left.equalTo(awayLargeBoxView.snp.left)
            make.top.equalTo(awayLargeBoxView.snp.bottom)
            make.width.equalTo(awayLargeBoxView.snp.width)
            make.height.equalTo(hashMarkHeight / 2)
        }
        
        // add the hashmarks to the views
        for i in 0...1 {
            var v: UIView?
            if i == 0 {
                v = homeTopBoxHashmarkView
            } else if i == 1 {
                v = homeBottomBoxHashmarkView
            }
            for i in 0...3 {
                let h = UIView()
                h.backgroundColor = .clear
                h.translatesAutoresizingMaskIntoConstraints = false
                h.layer.borderColor = lineColor.cgColor
                h.layer.borderWidth = lineWidth
                guard let hashMarkView = v else {
                    print("not a view")
                    return
                }
                hashMarkView.addSubview(h)
                
                h.snp.makeConstraints({ (make) in
                    make.width.equalTo(lineWidth)
                    make.bottom.equalToSuperview()
                    make.top.equalToSuperview()
                    if i == 0 {
                        make.left.equalToSuperview().offset(backboardOffset + boxHashOffset)
                    } else if i == 1 {
                        make.left.equalToSuperview().offset(backboardOffset + boxHashOffset + (boxHashOffset / 3))
                    } else if i == 2 {
                        make.left.equalToSuperview().offset(backboardOffset + (boxHashOffset * 2) + (boxHashOffset / 3))
                    } else if i == 3 {
                        make.left.equalToSuperview().offset(backboardOffset + (boxHashOffset * 3) + (boxHashOffset / 3))
                    }
                })
            }
            
        }
        
        for i in 0...1 {
            var v: UIView?
            if i == 0 {
                v = awayTopBoxHashmarkView
            } else if i == 1 {
                v = awayBottomBoxHashmarkView
            }
            for i in 0...3 {
                let h = UIView()
                h.backgroundColor = .clear
                h.translatesAutoresizingMaskIntoConstraints = false
                h.layer.borderColor = lineColor.cgColor
                h.layer.borderWidth = lineWidth
                guard let hashMarkView = v else {
                    print("not a view")
                    return
                }
                hashMarkView.addSubview(h)
                
                h.snp.makeConstraints({ (make) in
                    make.width.equalTo(lineWidth)
                    make.bottom.equalToSuperview()
                    make.top.equalToSuperview()
                    if i == 0 {
                        make.right.equalToSuperview().offset((backboardOffset + boxHashOffset) * -1)
                    } else if i == 1 {
                        make.right.equalToSuperview().offset((backboardOffset + boxHashOffset + (boxHashOffset / 3)) * -1)
                    } else if i == 2 {
                        make.right.equalToSuperview().offset((backboardOffset + (boxHashOffset * 2) + (boxHashOffset / 3)) * -1)
                    } else if i == 3 {
                        make.right.equalToSuperview().offset((backboardOffset + (boxHashOffset * 3) + (boxHashOffset / 3)) * -1)
                    }
                })
            }
            
        }
        
        // add the backboard and hoop
        homeBackboardView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(backboardHeight)
            make.left.equalTo(self.snp.left).offset(backboardOffset)
            make.centerY.equalToSuperview()
        }
        awayBackboardView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(backboardHeight)
            make.right.equalTo(self.snp.right).offset(-backboardOffset)
            make.centerY.equalToSuperview()
        }
        homeHoopView.snp.makeConstraints { (make) in
            make.width.equalTo(hoopWidth)
            make.height.equalTo(hoopWidth)
            make.left.equalTo(homeBackboardView.snp.right)
            make.centerY.equalToSuperview()
        }
        awayHoopView.snp.makeConstraints { (make) in
            make.width.equalTo(hoopWidth)
            make.height.equalTo(hoopWidth)
            make.right.equalTo(awayBackboardView.snp.left)
            make.centerY.equalToSuperview()
        }
        homeBackboardView.layer.borderWidth = lineWidth
        awayBackboardView.layer.borderWidth = lineWidth
        homeHoopView.layer.borderWidth = lineWidth
        homeHoopView.layer.cornerRadius = hoopWidth / 2
        awayHoopView.layer.borderWidth = lineWidth
        awayHoopView.layer.cornerRadius = hoopWidth / 2
        
        // add the foul line circle
        homeCircleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(homeLargeBoxView.snp.right).offset(-lineWidth / 2)
            make.centerY.equalToSuperview()
            make.width.equalTo(largeCircleWidth)
            make.height.equalTo(largeCircleWidth)
        }
        awayCircleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(awayLargeBoxView.snp.left).offset(lineWidth / 2)
            make.centerY.equalToSuperview()
            make.width.equalTo(largeCircleWidth)
            make.height.equalTo(largeCircleWidth)
        }
        homeCircleView.layer.cornerRadius = largeCircleWidth / 2
        awayCircleView.layer.cornerRadius = largeCircleWidth / 2
    }
    
    func returnHomeAreaBezierPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: homeAwayStraightLineWidth, y: 0))
        bezierPath.addCurve(to: CGPoint(x: homeAwayViewWidth, y: homeAwayViewHeight / 2), controlPoint1: CGPoint(x: homeAwayStraightLineWidth, y: 0), controlPoint2: CGPoint(x: homeAwayViewWidth, y: (homeAwayViewHeight * 0.125)))
        bezierPath.addCurve(to: CGPoint(x: homeAwayStraightLineWidth, y: homeAwayViewHeight), controlPoint1: CGPoint(x: homeAwayViewWidth, y: (homeAwayViewHeight * 0.875)), controlPoint2: CGPoint(x: homeAwayStraightLineWidth, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.close()
        
        return bezierPath
    }
    
    func returnAwayAreaBezierPath() -> UIBezierPath {        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: homeAwayViewWidth, y: 0))
        bezierPath.addLine(to: CGPoint(x: homeAwayViewWidth - homeAwayStraightLineWidth, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 0, y: homeAwayViewHeight / 2), controlPoint1: CGPoint(x: homeAwayViewWidth - homeAwayStraightLineWidth, y: 0), controlPoint2: CGPoint(x: 0, y: homeAwayViewHeight * 0.125))
        bezierPath.addCurve(to: CGPoint(x: homeAwayViewWidth - homeAwayStraightLineWidth, y: homeAwayViewHeight), controlPoint1: CGPoint(x: 0, y: homeAwayViewHeight * 0.875), controlPoint2: CGPoint(x: homeAwayViewWidth - homeAwayStraightLineWidth, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: homeAwayViewWidth, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: homeAwayViewWidth, y: 0))
        bezierPath.close()
    
        return bezierPath
    }
    
    func returnFreeThrowCurveBezierPath() -> UIBezierPath {
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 0, y: 1.5))
//        bezierPath.addCurve(to: CGPoint(x: 58.5, y: 60), controlPoint1: CGPoint(x: 0, y: 1.5), controlPoint2: CGPoint(x: 58.5, y: 1.01))
//        bezierPath.addCurve(to: CGPoint(x: 0, y: 118.5), controlPoint1: CGPoint(x: 58.5, y: 118.99), controlPoint2: CGPoint(x: 0, y: 118.5))
//        UIColor.black.setStroke()
//        bezierPath.lineWidth = 3
//        bezierPath.stroke()
        
//        let lineOffset: CGFloat = lineWidth / 2
//        let halfLargeCircleWidth = largeCircleWidth / 2
//        let halfWithOffset = halfLargeCircleWidth - lineOffset
//        let fullWithOffset = largeCircleWidth - lineOffset
//        
        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 0, y: lineOffset))
//        bezierPath.addCurve(to: CGPoint(x: halfWithOffset, y: halfLargeCircleWidth), controlPoint1: CGPoint(x: 0, y: lineOffset), controlPoint2: CGPoint(x: halfWithOffset, y: lineOffset))
//        bezierPath.addCurve(to: CGPoint(x: 0, y: fullWithOffset), controlPoint1: CGPoint(x: halfWithOffset, y: largeCircleWidth), controlPoint2: CGPoint(x: 0, y: fullWithOffset))
//        bezierPath.stroke()
        
        return bezierPath
    }
    
    func drawToScale() {
        guard let width = dataSource?.widthForProCourt(self) else {
            print("No width set in datasource")
            return
        }
        
        courtViewWidth = width
        setupConstants()
        drawCourt()
    }
    
}

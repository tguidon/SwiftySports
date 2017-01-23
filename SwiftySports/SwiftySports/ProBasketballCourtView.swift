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
    
    // court
    private let homeSmallBoxView = UIView()
    private let homeLargeBoxView = UIView()
    private let homeDashedSemiCircleView = UIView()
    private let homeSemiCircleView = UIView()
    private let homeTopBoxHashmarkView = UIView()
    private let homeBottomBoxHashmarkView = UIView()
    private let homeBackboardView = UIView()
    private let homeHoopView = UIView()
    
    
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
    private var homeCourtCircles: [UIView] = []
    
    
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
        homeCourtLines = [homeSmallBoxView, homeLargeBoxView, homeBackboardView, homeHoopView]
        homeCourtHashMarks = [homeTopBoxHashmarkView, homeBottomBoxHashmarkView]
        homeCourtCircles = [homeDashedSemiCircleView, homeSemiCircleView]
        
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
        
        // add the home court
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
        homeShape.position = CGPoint(x: 0.5, y: 0.5)
        homeShape.lineWidth = lineWidth
        homeView.layer.addSublayer(homeShape)
        
        // boxes
        for box in homeCourtLines {
            box.backgroundColor = .clear
            box.translatesAutoresizingMaskIntoConstraints = false
            box.layer.borderColor = lineColor.cgColor
            box.layer.borderWidth = lineWidth
            homeView.addSubview(box)
        }
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
        
        // hashmarks
        for hash in homeCourtHashMarks {
            hash.backgroundColor = .clear
            hash.translatesAutoresizingMaskIntoConstraints = false
            homeView.addSubview(hash)
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
        
        // add the backboard and hoop
        homeBackboardView.snp.makeConstraints { (make) in
            make.width.equalTo(lineWidth)
            make.height.equalTo(backboardHeight)
            make.left.equalTo(self.snp.left).offset(backboardOffset)
            make.centerY.equalToSuperview()
        }
        homeHoopView.snp.makeConstraints { (make) in
            make.width.equalTo(hoopWidth)
            make.height.equalTo(hoopWidth)
            make.left.equalTo(homeBackboardView.snp.right)
            make.centerY.equalToSuperview()
        }
        homeBackboardView.layer.borderWidth = lineWidth
        homeHoopView.layer.borderWidth = lineWidth
        homeHoopView.layer.cornerRadius = hoopWidth / 2
        
        // add the foul line circle
        for circle in homeCourtCircles {
            circle.backgroundColor = .clear
            circle.translatesAutoresizingMaskIntoConstraints = false
            homeView.addSubview(circle)
        }
        homeDashedSemiCircleView.backgroundColor = .red
        homeSemiCircleView.backgroundColor = .blue
        homeDashedSemiCircleView.snp.makeConstraints { (make) in
            make.width.equalTo(largeCircleWidth / 2)
            make.height.equalTo(largeCircleWidth)
            make.centerY.equalToSuperview()
            make.left.equalTo(homeLargeBoxView.snp.right).offset((-largeCircleWidth / 2) + (-lineWidth / 2))
        }
        homeSemiCircleView.snp.makeConstraints { (make) in
            make.width.equalTo(largeCircleWidth / 2)
            make.height.equalTo(largeCircleWidth)
            make.centerY.equalToSuperview()
            make.left.equalTo(homeLargeBoxView.snp.right).offset((-lineWidth / 2))
        }
        
        // add the away court which is a flip of
    }
    
    func returnHomeAreaBezierPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.5, y: 0.5))
        bezierPath.addLine(to: CGPoint(x: homeAwayStraightLineWidth, y: 0.5))
        bezierPath.addCurve(to: CGPoint(x: homeAwayViewWidth, y: homeAwayViewHeight / 2), controlPoint1: CGPoint(x: homeAwayStraightLineWidth, y: 0.5), controlPoint2: CGPoint(x: homeAwayViewWidth, y: (homeAwayViewHeight * 0.125)))
        bezierPath.addCurve(to: CGPoint(x: homeAwayStraightLineWidth, y: homeAwayViewHeight), controlPoint1: CGPoint(x: homeAwayViewWidth, y: (homeAwayViewHeight * 0.875)), controlPoint2: CGPoint(x: homeAwayStraightLineWidth, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: 0.5))
        bezierPath.close()
        
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

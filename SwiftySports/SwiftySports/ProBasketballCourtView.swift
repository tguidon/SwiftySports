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
    
    // UI
    // proBasketballCourtView holds the court's UI elements
    // dataView holds potential data overlays
    private let proBasketballCourtView = UIView()
    private let dataView = UIView()
    
    private let homeView = UIView()
    private let awayView = UIView()
    private let topLeftHashMarkView = UIView()
    private let bottomLeftHashMarkView = UIView()
    private let topRightHashMarkView = UIView()
    private let bottomRightHashMarkView = UIView()
    
    private let halfCourtLineView = UIView()
    private let halfCourtSmallCircleView = UIView()
    private let halfCourtLargeCircleView = UIView()
    
    
    private var hashMarkLines: [UIView] = []
    private var halfCourtLines: [UIView] = []
    
    // I dont know the rules of basketball and what the different areas
    // on the court are called. If you're a basketball fan I apologize 🙃
    
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
    
    private var hashMarkOffset: CGFloat = 0
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        hashMarkLines = [topLeftHashMarkView, bottomLeftHashMarkView, topRightHashMarkView, bottomRightHashMarkView]
        halfCourtLines = [halfCourtLineView, halfCourtSmallCircleView, halfCourtLargeCircleView]
        
        self.backgroundColor = .clear
        
        setupConstants()
    }
    
    func setupConstants() {
        courtViewHeight = courtViewWidth * (25 / 47)
        
        let lineWidthRatio: CGFloat = 0.85 / kRealCourtWidth
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
        
        print(homeAwayViewWidth, homeAwayViewHeight, homeAwayStraightLineWidth)
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
        homeView.backgroundColor = .red
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
        
        // add the away court which is a flip of
    }
    
    func returnHomeAreaBezierPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: homeAwayStraightLineWidth, y: 0))
        bezierPath.addCurve(to: CGPoint(x: homeAwayViewWidth, y: homeAwayViewHeight / 1.5), controlPoint1: CGPoint(x: homeAwayStraightLineWidth, y: 0), controlPoint2: CGPoint(x: homeAwayViewWidth, y: 0))
        bezierPath.addCurve(to: CGPoint(x: homeAwayStraightLineWidth, y: homeAwayViewHeight), controlPoint1: CGPoint(x: homeAwayViewWidth, y: homeAwayViewHeight), controlPoint2: CGPoint(x: homeAwayStraightLineWidth, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0, y: homeAwayViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
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

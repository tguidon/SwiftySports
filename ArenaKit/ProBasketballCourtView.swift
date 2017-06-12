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
    let proBasketballCourt = ProBasketballCourt()
    
    // I dont know the rules of basketball and what the different areas
    // on the court are called. If you're a basketball fan I apologize 🙃
    // UI
    // proBasketballCourtView holds the court's UI elements
    // dataView holds potential data overlays
    private let proBasketballCourtView = UIView()
    private let dataView = UIView()
    
    private let homeZoneView = UIView()
    private let awayZoneView = UIView()
    
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
    
    private var zoneViews: [UIView] = []
    private var hashMarkLines: [UIView] = []
    private var halfCourtLines: [UIView] = []
    private var homeCourtLines: [UIView] = []
    private var homeCourtHashMarks: [UIView] = []
    private var awayCourtLines: [UIView] = []
    private var awayCourtHashMarks: [UIView] = []
    
    // colors
    var courtColor: UIColor = UIColor(red:0.81, green:0.62, blue:0.54, alpha:1.00) {
        didSet {
            draw()
        }
    }
    var lineColor: UIColor = .white {
        didSet {
            draw()
        }
    }
    var centerCircleColor: UIColor = .purple {
        didSet {
            draw()
        }
    }
    var boxColor: UIColor = .blue {
        didSet {
            draw()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        zoneViews = [homeZoneView, awayZoneView]
        hashMarkLines = [topLeftHashMarkView, bottomLeftHashMarkView, topRightHashMarkView, bottomRightHashMarkView]
        halfCourtLines = [halfCourtLineView, halfCourtSmallCircleView, halfCourtLargeCircleView]
        homeCourtLines = [homeSmallBoxView, homeLargeBoxView, homeBackboardView, homeHoopView, homeCircleView]
        homeCourtHashMarks = [homeTopBoxHashmarkView, homeBottomBoxHashmarkView]
        awayCourtLines = [awaySmallBoxView, awayLargeBoxView, awayBackboardView, awayHoopView, awayCircleView]
        awayCourtHashMarks = [awayTopBoxHashmarkView, awayBottomBoxHashmarkView]
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }
    
    func setup() {
        proBasketballCourtView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(proBasketballCourtView)
        hashMarkLines.forEach({ proBasketballCourtView.addSubview($0) })
        halfCourtLines.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        halfCourtLines.forEach({ proBasketballCourtView.addSubview($0) })
        zoneViews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        zoneViews.forEach({ proBasketballCourtView.addSubview($0) })
        homeCourtLines.forEach({ homeZoneView.addSubview($0) })
        awayCourtLines.forEach({ awayZoneView.addSubview($0) })
        let courtLines = [homeCourtLines, awayCourtLines]
        for court in courtLines {
            court.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        }
        homeCourtHashMarks.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        homeCourtHashMarks.forEach({ homeZoneView.addSubview($0) })
        awayCourtHashMarks.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        awayCourtHashMarks.forEach({ awayZoneView.addSubview($0) })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        proBasketballCourt.initWithWidth(self.frame.width)
        draw()
    }
    
    func draw() {
        // Draw basketball court
        proBasketballCourtView.backgroundColor = courtColor
        proBasketballCourtView.layer.borderColor = lineColor.cgColor
        proBasketballCourtView.layer.borderWidth = proBasketballCourt.lineWidth
        proBasketballCourtView.snp.remakeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalToSuperview()
        }
        
        // Draw the hashmarks
        hashMarkLines.forEach({ $0.backgroundColor = lineColor })
        hashMarkLines.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        topLeftHashMarkView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.height.equalTo(proBasketballCourt.hashMarkHeight)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(proBasketballCourt.hashMarkOffset)
        }
        bottomLeftHashMarkView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.height.equalTo(proBasketballCourt.hashMarkHeight)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(proBasketballCourt.hashMarkOffset)
        }
        topRightHashMarkView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.height.equalTo(proBasketballCourt.hashMarkHeight)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-proBasketballCourt.hashMarkOffset)
        }
        bottomRightHashMarkView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.height.equalTo(proBasketballCourt.hashMarkHeight)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-proBasketballCourt.hashMarkOffset)
        }
        
        // Draw the half court line and circles
        halfCourtLines.forEach({ $0.backgroundColor = .clear })
        halfCourtLines.forEach({ $0.layer.borderColor = lineColor.cgColor })
        halfCourtLines.forEach({ $0.layer.borderWidth = proBasketballCourt.lineWidth })
        halfCourtLineView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        halfCourtSmallCircleView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.smallCircleWidth)
            make.height.equalTo(proBasketballCourt.smallCircleWidth)
            make.center.equalToSuperview()
        }
        halfCourtLargeCircleView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.largeCircleWidth)
            make.height.equalTo(proBasketballCourt.largeCircleWidth)
            make.center.equalToSuperview()
        }
        halfCourtSmallCircleView.layer.cornerRadius = proBasketballCourt.smallCircleWidth / 2
        halfCourtLargeCircleView.layer.cornerRadius = proBasketballCourt.largeCircleWidth / 2
        
        // Draw the home and away court
        zoneViews.forEach({ $0.backgroundColor = .clear })
        homeZoneView.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(proBasketballCourt.zoneViewWidth)
            make.height.equalTo(proBasketballCourt.zoneViewHeight)
        }
        awayZoneView.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(proBasketballCourt.zoneViewWidth)
            make.height.equalTo(proBasketballCourt.zoneViewHeight)
        }
        let homeShape = CAShapeLayer()
        homeShape.path = returnHomeAreaBezierPath().cgPath
        homeShape.strokeColor = lineColor.cgColor
        homeShape.fillColor = UIColor.clear.cgColor
        homeShape.position = CGPoint(x: 0, y: 0)
        homeShape.lineWidth = proBasketballCourt.lineWidth
        let awayShape = CAShapeLayer()
        awayShape.path = returnAwayAreaBezierPath().cgPath
        awayShape.strokeColor = lineColor.cgColor
        awayShape.fillColor = UIColor.clear.cgColor
        awayShape.position = CGPoint(x: 0.5, y: 0.5)
        awayShape.lineWidth = proBasketballCourt.lineWidth
        homeZoneView.layer.addSublayer(homeShape)
        awayZoneView.layer.addSublayer(awayShape)
        
        // Draw all lines
        let courtLines = [homeCourtLines, awayCourtLines]
        for court in courtLines {
            court.forEach({ $0.backgroundColor = .clear })
            court.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
            court.forEach({ $0.layer.borderColor = lineColor.cgColor })
            court.forEach({ $0.layer.borderWidth = proBasketballCourt.lineWidth })
        }
        
        // Draw boxes
        homeLargeBoxView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(proBasketballCourt.boxWidth)
            make.height.equalTo(proBasketballCourt.largeBoxHeight)
        }
        homeSmallBoxView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(proBasketballCourt.boxWidth)
            make.height.equalTo(proBasketballCourt.smallBoxHeight)
        }
        awayLargeBoxView.snp.remakeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(proBasketballCourt.boxWidth)
            make.height.equalTo(proBasketballCourt.largeBoxHeight)
        }
        awaySmallBoxView.snp.remakeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(proBasketballCourt.boxWidth)
            make.height.equalTo(proBasketballCourt.smallBoxHeight)
        }
        
        // Draw hashmarks
        homeCourtHashMarks.forEach({ $0.backgroundColor = .clear })
        awayCourtHashMarks.forEach({ $0.backgroundColor = .clear })
        homeTopBoxHashmarkView.snp.remakeConstraints { (make) in
            make.left.equalTo(homeLargeBoxView.snp.left)
            make.bottom.equalTo(homeLargeBoxView.snp.top)
            make.width.equalTo(homeLargeBoxView.snp.width)
            make.height.equalTo(proBasketballCourt.hashMarkHeight / 2)
        }
        homeBottomBoxHashmarkView.snp.remakeConstraints { (make) in
            make.left.equalTo(homeLargeBoxView.snp.left)
            make.top.equalTo(homeLargeBoxView.snp.bottom)
            make.width.equalTo(homeLargeBoxView.snp.width)
            make.height.equalTo(proBasketballCourt.hashMarkHeight / 2)
        }
        awayTopBoxHashmarkView.snp.remakeConstraints { (make) in
            make.left.equalTo(awayLargeBoxView.snp.left)
            make.bottom.equalTo(awayLargeBoxView.snp.top)
            make.width.equalTo(awayLargeBoxView.snp.width)
            make.height.equalTo(proBasketballCourt.hashMarkHeight / 2)
        }
        awayBottomBoxHashmarkView.snp.remakeConstraints { (make) in
            make.left.equalTo(awayLargeBoxView.snp.left)
            make.top.equalTo(awayLargeBoxView.snp.bottom)
            make.width.equalTo(awayLargeBoxView.snp.width)
            make.height.equalTo(proBasketballCourt.hashMarkHeight / 2)
        }
        
        // Draw the hashmarks in the views
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
                h.layer.borderWidth = proBasketballCourt.lineWidth
                guard let hashMarkView = v else {
                    print("not a view")
                    return
                }
                hashMarkView.addSubview(h)
                
                h.snp.remakeConstraints({ (make) in
                    make.width.equalTo(proBasketballCourt.lineWidth)
                    make.bottom.equalToSuperview()
                    make.top.equalToSuperview()
                    let backboardOffset = proBasketballCourt.backboardOffset
                    let boxHashOffset = proBasketballCourt.boxHashOffset
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
                h.layer.borderWidth = proBasketballCourt.lineWidth
                guard let hashMarkView = v else {
                    print("not a view")
                    return
                }
                hashMarkView.addSubview(h)
                
                h.snp.remakeConstraints({ (make) in
                    make.width.equalTo(proBasketballCourt.lineWidth)
                    make.bottom.equalToSuperview()
                    make.top.equalToSuperview()
                    let backboardOffset = proBasketballCourt.backboardOffset
                    let boxHashOffset = proBasketballCourt.boxHashOffset
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
        
        // Draw the backboard and hoop
        homeBackboardView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.height.equalTo(proBasketballCourt.backboardHeight)
            make.left.equalTo(self.snp.left).offset(proBasketballCourt.backboardOffset)
            make.centerY.equalToSuperview()
        }
        awayBackboardView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.lineWidth)
            make.height.equalTo(proBasketballCourt.backboardHeight)
            make.right.equalTo(self.snp.right).offset(-proBasketballCourt.backboardOffset)
            make.centerY.equalToSuperview()
        }
        homeHoopView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.hoopWidth)
            make.height.equalTo(proBasketballCourt.hoopWidth)
            make.left.equalTo(homeBackboardView.snp.right)
            make.centerY.equalToSuperview()
        }
        awayHoopView.snp.remakeConstraints { (make) in
            make.width.equalTo(proBasketballCourt.hoopWidth)
            make.height.equalTo(proBasketballCourt.hoopWidth)
            make.right.equalTo(awayBackboardView.snp.left)
            make.centerY.equalToSuperview()
        }
        
        let lineWidth = proBasketballCourt.lineWidth
        let hoopWidth = proBasketballCourt.hoopWidth
        homeBackboardView.layer.borderWidth = lineWidth
        awayBackboardView.layer.borderWidth = lineWidth
        homeHoopView.layer.borderWidth = lineWidth
        homeHoopView.layer.cornerRadius = hoopWidth / 2
        awayHoopView.layer.borderWidth = lineWidth
        awayHoopView.layer.cornerRadius = hoopWidth / 2
        
        // Draw the foul line circle
        homeCircleView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(homeLargeBoxView.snp.right).offset(-proBasketballCourt.lineWidth / 2)
            make.centerY.equalToSuperview()
            make.width.equalTo(proBasketballCourt.largeCircleWidth)
            make.height.equalTo(proBasketballCourt.largeCircleWidth)
        }
        awayCircleView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(awayLargeBoxView.snp.left).offset(proBasketballCourt.lineWidth / 2)
            make.centerY.equalToSuperview()
            make.width.equalTo(proBasketballCourt.largeCircleWidth)
            make.height.equalTo(proBasketballCourt.largeCircleWidth)
        }
        homeCircleView.layer.cornerRadius = proBasketballCourt.largeCircleWidth / 2
        awayCircleView.layer.cornerRadius = proBasketballCourt.largeCircleWidth / 2
    }
    
    func returnHomeAreaBezierPath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let zoneViewWidth = proBasketballCourt.zoneViewWidth
        let zoneViewHeight = proBasketballCourt.zoneViewHeight
        let zoneStraightLineWidth = proBasketballCourt.zoneStraightLineWidth
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: zoneStraightLineWidth, y: 0))
        bezierPath.addCurve(to: CGPoint(x: zoneViewWidth, y: zoneViewHeight / 2), controlPoint1: CGPoint(x: zoneStraightLineWidth, y: 0), controlPoint2: CGPoint(x: zoneViewWidth, y: (zoneViewHeight * 0.125)))
        bezierPath.addCurve(to: CGPoint(x: zoneStraightLineWidth, y: zoneViewHeight), controlPoint1: CGPoint(x: zoneViewWidth, y: (zoneViewHeight * 0.875)), controlPoint2: CGPoint(x: zoneStraightLineWidth, y: zoneViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0, y: zoneViewHeight))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.close()
        
        return bezierPath
    }
    
    func returnAwayAreaBezierPath() -> UIBezierPath {        
        let bezierPath = UIBezierPath()
        let zoneViewWidth = proBasketballCourt.zoneViewWidth
        let zoneViewHeight = proBasketballCourt.zoneViewHeight
        let zoneStraightLineWidth = proBasketballCourt.zoneStraightLineWidth
        bezierPath.move(to: CGPoint(x: zoneViewWidth, y: 0))
        bezierPath.addLine(to: CGPoint(x: zoneViewWidth - zoneStraightLineWidth, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 0, y: zoneViewHeight / 2), controlPoint1: CGPoint(x: zoneViewWidth - zoneStraightLineWidth, y: 0), controlPoint2: CGPoint(x: 0, y: zoneViewHeight * 0.125))
        bezierPath.addCurve(to: CGPoint(x: zoneViewWidth - zoneStraightLineWidth, y: zoneViewHeight), controlPoint1: CGPoint(x: 0, y: zoneViewHeight * 0.875), controlPoint2: CGPoint(x: zoneViewWidth - zoneStraightLineWidth, y: zoneViewHeight))
        bezierPath.addLine(to: CGPoint(x: zoneViewWidth, y: zoneViewHeight))
        bezierPath.addLine(to: CGPoint(x: zoneViewWidth, y: 0))
        bezierPath.close()
    
        return bezierPath
    }
    
}

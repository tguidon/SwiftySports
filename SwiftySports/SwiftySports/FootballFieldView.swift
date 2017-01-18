//
//  FootballFieldView.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

protocol FootballFieldViewDataSource {
    func widthForFootballField(_ footballFieldView: FootballFieldView) -> CGFloat
}

class FootballFieldView: UIView {
    
    var dataSource: FootballFieldViewDataSource?
    
    // Don't change these constants, used for ratios
    private let kRealFieldWidth: CGFloat = 78.0
    private let kRealFieldHeight: CGFloat = 36.0
    
    // UI
    // soccerFieldView holds the rink's UI elements
    // dataView holds potential data overlays
    private let footballFieldView = UIView()
    private let dataView = UIView()
    
    // Array of all lines
    private var fieldLines: [UIView] = []
    
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
    private var footballFieldViewWidth: CGFloat = 0
    private var footballFieldViewHeight: CGFloat = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // build array of lines
        
        self.backgroundColor = .clear
        
        setupConstants()
    }
    
    func setupConstants() {
        
    }
    
    func drawField() {
        
        
    }
    
    func drawToScale() {
        guard let width = dataSource?.widthForFootballField(self) else {
            print("No width set in dataSource")
            return
        }
        
        footballFieldViewWidth = width
        setupConstants()
        drawField()
    }
    
}

//
//  ViewController.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IceRinkViewDataSource, TennisCourtViewDataSource, ProBasketballCourtViewDataSource, SoccerFieldViewDataSource {
    @IBOutlet weak var iceRinkView: IceRinkView!
    @IBOutlet weak var tennisCourtView: TennisCourtView!
    @IBOutlet weak var proBasketballCourtView: ProBasketballCourtView!
    @IBOutlet weak var soccerFieldView: SoccerFieldView!

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var swiftySportsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iceRinkView.dataSource = self
        iceRinkView.drawToScale()
        
        tennisCourtView.dataSource = self
        tennisCourtView.drawToScale()
        
        proBasketballCourtView.dataSource = self
        proBasketballCourtView.drawToScale()
        
        soccerFieldView.dataSource = self
        soccerFieldView.drawToScale()
    }
    
    func widthForRink(_ iceRinkView: IceRinkView) -> CGFloat {
        return 320.0
    }
    
    func widthForCourt(_ tennisCourtView: TennisCourtView) -> CGFloat {
        return 320.0
    }
    
    func widthForProCourt(_ proBasketballCourtView: ProBasketballCourtView) -> CGFloat {
        return 94.0
    }
    
    func widthForSoccerField(_ soccerFieldView: SoccerFieldView) -> CGFloat {
        return 320.0
    }

}

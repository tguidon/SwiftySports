//
//  ViewController.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var iceRinkView: IceRinkView!
    @IBOutlet weak var tennisCourtView: TennisCourtView!
    @IBOutlet weak var proBasketballCourtView: ProBasketballCourtView!
    @IBOutlet weak var soccerFieldView: SoccerFieldView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var swiftySportsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        iceRinkView.drawToScale()
        tennisCourtView.drawToScale()
        proBasketballCourtView.drawToScale()
        soccerFieldView.drawToScale()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}

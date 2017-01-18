//
//  ViewController.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IceRinkViewDataSource, TennisCourtViewDataSource {
    @IBOutlet weak var iceRinkView: IceRinkView!
    @IBOutlet weak var tennisCourtView: TennisCourtView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iceRinkView.dataSource = self
        iceRinkView.drawToScale()
        
        tennisCourtView.dataSource = self
        tennisCourtView.drawToScale()
    }
    
    func widthForRink(_ iceRinkView: IceRinkView) -> CGFloat {
        return 320.0
    }
    
    func widthForCourt(_ tennisCourtView: TennisCourtView) -> CGFloat {
        return 320.0
    }

}

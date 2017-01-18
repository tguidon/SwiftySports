//
//  ViewController.swift
//  SwiftySports
//
//  Created by Taylor Guidon on 1/17/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IceRinkViewDataSource {
    @IBOutlet weak var iceRinkView: IceRinkView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iceRinkView.dataSource = self
        iceRinkView.drawToScale()
    }
    
    func widthForIceRink(_ iceRinkView: IceRinkView) -> CGFloat {
        return 320.0
    }

}

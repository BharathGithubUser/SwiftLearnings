//
//  ViewController.swift
//  SwiftLearnings
//
//  Created by user on 30/07/18.
//  Copyright © 2018 this. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        splashImageView.loadGif(name: "splash")
        print("loaded the image!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


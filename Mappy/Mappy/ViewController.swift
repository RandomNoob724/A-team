//
//  ViewController.swift
//  Mappy
//
//  Created by Emil Persson on 2019-11-14.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}


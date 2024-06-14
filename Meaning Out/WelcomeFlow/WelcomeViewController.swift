//
//  ViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/13/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.requestSearchResult(query: "가방")
        
    }
}


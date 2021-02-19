//  ViewController.swift
//  videoEditing
//  Created by macbook on 7/19/20.
//  Copyright © 2020 macbook. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view, typically from a nib.
       
     }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
          navigationController?.navigationBar.isHidden = true
      }
   
}


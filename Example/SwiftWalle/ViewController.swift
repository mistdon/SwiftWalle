//
//  ViewController.swift
//  SwiftWalle
//
//  Created by mistdon on 03/27/2020.
//  Copyright (c) 2020 mistdon. All rights reserved.
//

import UIKit
import SwiftWalle

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if Platform.isSimulator {
            print("YES")
        }
        view.backgroundColor = UIColor(hex6: 0xeb3d34)
        
        "aa".isBlank
        
//        let att = NSAttributedString(string: "Hello world!")
//        att.high
    
        
        var aa = ["a", "b"]
        let indexp = IndexPath(row: 0, section: 0)
        let res = aa(indexp)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let att = NSAttributedString(string: "ss", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex6: "11111111111")])
        view.backgroundColor = UIColor(hex6: "1")
    }
}


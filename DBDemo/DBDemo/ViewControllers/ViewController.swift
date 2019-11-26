//
//  ViewController.swift
//  DBDemo
//
//  Created by Sandeep Parmar on 26/11/19.
//  Copyright © 2019 Sandeep Parmar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func coreDatabaseDidPressed(_ sender : UIButton){
        
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "CoreDatabaseVCViewController")as! CoreDatabaseVCViewController
        
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func sqliteDatabaseDidPressed(_ sender : UIButton){
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SqliteViewController")as! SqliteViewController
        
        self.navigationController?.pushViewController(obj, animated: true)
    }

}


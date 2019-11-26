//
//  SqliteViewController.swift
//  DBDemo
//
//  Created by Sandeep Parmar on 26/11/19.
//  Copyright © 2019 Sandeep Parmar. All rights reserved.
//

import UIKit

class SqliteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sqliteDbStore = SqliteDBStore()
        let record = Record(name: "Sandeep", employeeId: "102345", designation: "iOS Developers")
        sqliteDbStore.create(record: record)
        //let r = try sqliteDbStore.read(employeeID: "ABC123")
        record.designation = "Sr iOS developer"
        sqliteDbStore.update(record: record)
        sqliteDbStore.delete(employeeId: record.employeeId)
    }    
}

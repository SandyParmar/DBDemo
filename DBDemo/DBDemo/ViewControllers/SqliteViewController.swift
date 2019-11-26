//
//  SqliteViewController.swift
//  DBDemo
//
//  Created by Sandeep Parmar on 26/11/19.
//  Copyright © 2019 Sandeep Parmar. All rights reserved.
//

import UIKit

class SqliteViewController: UIViewController {
    
    @IBOutlet weak var textV: UITextView!
    
    let record = Record(name: "Sandeep", employeeId: "102345", designation: "iOS Developers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SqliteDBStore.sharedInstance.delegateSqlite = self
    }
    
    @IBAction func insertRecordDidPressed(_ sender: UIButton){
        
        SqliteDBStore.sharedInstance.create(record: record)
    }
    
    @IBAction func updateRecordDidPressed(_ sender: UIButton){
        record.designation = "Sr iOS developer"
        SqliteDBStore.sharedInstance.update(record: record)
    }
    
    @IBAction func fetechRecordDidPressed(_ sender: UIButton){
        
        do{
            let r = try SqliteDBStore.sharedInstance.read(employeeID: "102345")
            
            self.textV.text = "Name: \(r.name), EmpId: \(r.employeeId) Dest: \(r.designation)"
        }
        catch{
            
        }
    }
    
    @IBAction func deleteRecordDidPressed(_ sender: UIButton){
        SqliteDBStore.sharedInstance.delete(employeeId: record.employeeId)
        
    }
}
extension SqliteViewController : SqliteDBStoreDelegate{
    func databaseResponseWithMessage(message: String) {
        
        DispatchQueue.main.async {
            self.textV.text = message
        }
    }
    
    
}

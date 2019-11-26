//
//  Record.swift
//  DBDemo
//
//  Created by Sandeep Parmar on 26/11/19.
//  Copyright © 2019 Sandeep Parmar. All rights reserved.
//

import Foundation

class Record {
    // Name | Employee Id | Designation
    var name: String
    var employeeId: String
    var designation: String
    
    init(name: String, employeeId: String, designation: String) {
        self.name = name
        self.employeeId = employeeId
        self.designation = designation
    }
}

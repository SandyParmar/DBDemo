//
//  SqliteDBStore.swift
//  DBDemo
//
//  Created by Sandeep Parmar on 26/11/19.
//  Copyright © 2019 Sandeep Parmar. All rights reserved.
//

import Foundation
import os.log
import SQLite3

protocol SqliteDBStoreDelegate {
    func databaseResponseWithMessage(message:String)
}

class SqliteDBStore {
    
    public static var sharedInstance : SqliteDBStore {
          get { return instance }
      }
      
      static let instance : SqliteDBStore = SqliteDBStore()
    
    var delegateSqlite : SqliteDBStoreDelegate? = nil
    
    
    
    // Get the URL to db store file
    let dbURL: URL
    // The database pointer.
    var db: OpaquePointer?
    // Prepared statement https://www.sqlite.org/c3ref/stmt.html to insert an event into Table.
    // we use prepared statements for efficiency and safe guard against sql injection.
    var insertEntryStmt: OpaquePointer?
    var readEntryStmt: OpaquePointer?
    var updateEntryStmt: OpaquePointer?
    var deleteEntryStmt: OpaquePointer?
    
    
    
    init() {
        do {
            do {
                dbURL = try FileManager.default
                    .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent("DBDemo.db")
                delegateSqlite?.databaseResponseWithMessage(message: "URL: \(dbURL.absoluteString)")
            } catch {
                //TODO: Just logging the error and returning empty path URL here. Handle the error gracefully after logging
                delegateSqlite?.databaseResponseWithMessage(message:"Some error occurred. Returning empty path.")
                dbURL = URL(fileURLWithPath: "")
                return
            }
            
            try openDB()
            try createTables()
            } catch {
                //TODO: Handle the error gracefully after logging
                delegateSqlite?.databaseResponseWithMessage(message:"Some error occurred. Returning.")
                return
            }
    }
    
    // Command: sqlite3_open(dbURL.path, &db)
    // Open the DB at the given path. If file does not exists, it will create one for you
    func openDB() throws {
        if sqlite3_open(dbURL.path, &db) != SQLITE_OK { // error mostly because of corrupt database
            delegateSqlite?.databaseResponseWithMessage(message: "error opening database at \(dbURL.absoluteString)")
//            deleteDB(dbURL: dbURL)
            throw SqliteError(message: "error opening database \(dbURL.absoluteString)")
        }
    }
    
    // Code to delete a db file. Useful to invoke in case of a corrupt DB and re-create another
    func deleteDB(dbURL: URL) {
        delegateSqlite?.databaseResponseWithMessage(message: "removing db")
        do {
            try FileManager.default.removeItem(at: dbURL)
        } catch {
            delegateSqlite?.databaseResponseWithMessage(message: "exception while removing db \(error.localizedDescription)")
        }
    }
    
    func createTables() throws {
        // create the tables if they dont exist.
        
        // create the table to store the entries.
        // ID | Name | Employee Id | Designation
        let ret =  sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Records (id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT, Name TEXT NOT NULL, EmployeeID TEXT UNIQUE NOT NULL, Designation TEXT NOT NULL)", nil, nil, nil)
        if (ret != SQLITE_OK) { // corrupt database.
            logDbErr("Error creating db table - Records")
            throw SqliteError(message: "unable to create table Records")
        }
        
    }
    
    func logDbErr(_ msg: String) {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        delegateSqlite?.databaseResponseWithMessage(message: "ERROR %s : \(msg) \(errmsg)")
    }
}

// Indicates an exception during a SQLite Operation.
class SqliteError : Error {
    var message = ""
    var error = SQLITE_ERROR
    init(message: String = "") {
        self.message = message
    }
    init(error: Int32) {
        self.error = error
    }
}

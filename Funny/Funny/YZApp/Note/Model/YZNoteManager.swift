//
//  YZNoteManager.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNoteManager: NSObject {

    static let manager = YZNoteManager()
    private var databaseQueue: FMDatabaseQueue!
    private override init() {
        let DBPath = Document + "/FunnyDB"
        if !FileManager.default.fileExists(atPath: DBPath) {
            do {
                try FileManager.default.createDirectory(atPath: DBPath, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        ///
        databaseQueue = FMDatabaseQueue(path: DBPath + "/Funny.db")
        databaseQueue.inDatabase { (db) in
            let note = "create table if not exists FunnyNote(ID integer primary key,time bigint,title nvarchar(4000))"
            let live = "create table if not exists FunnyLive(ID integer primary key,name nvarchar(4000),liveAddress nvarchar(4000))"
            db?.executeUpdate(note, withArgumentsIn: nil)
            db?.executeUpdate(live, withArgumentsIn: nil)
        }
    }
//MARK: - Live
    public func addLive(_ live: YZYKDBModel) {
        var sql = "select * from FunnyLive where (liveAddress = ?)"
        var models = [YZYKDBModel]()
        self.databaseQueue.inTransaction { (db, rollback) in
            let result = db?.executeQuery(sql, withArgumentsIn: [live.liveAddress])
            while (result?.next())! {
                let model = YZYKDBModel()
                model.name = result?.string(forColumn: "name")
                model.liveAddress = result?.string(forColumn: "liveAddress")
                models.append(model)
            }
            result?.close()
        }
        if models.count > 0 {
            updateLive(live)
        }else{
            sql = "insert into FunnyLive (name,liveAddress) values(?,?)"
            self.databaseQueue.inTransaction { (db, rollback) in
                db?.executeUpdate(sql, withArgumentsIn: [live.name,live.liveAddress])
            }
        }
    }
    
    public func deleteLive(_ live: YZYKDBModel) {
        let sql = "delete from FunnyLive where liveAddress = ?"
        self.databaseQueue.inTransaction { (db, rollback) in
            db?.executeUpdate(sql, withArgumentsIn: [live.liveAddress])
        }
    }
    
    public func updateLive(_ live: YZYKDBModel) {
        let sql = "update FunnyLive set name = ? where liveAddress = ?"
        self.databaseQueue.inTransaction { (db, rollback) in
            db?.executeUpdate(sql, withArgumentsIn: [live.name,live.liveAddress])
        }
    }
    
    public func allLives() ->[YZYKDBModel]! {
        var lives = [YZYKDBModel]()
        let sql = "select * from FunnyLive"
        self.databaseQueue.inTransaction { (db, rollback) in
            let result = db?.executeQuery(sql, withArgumentsIn: nil)
            while (result?.next())! {
                let model = YZYKDBModel()
                model.name = result?.string(forColumn: "name")
                model.liveAddress = result?.string(forColumn: "liveAddress")
                lives.append(model)
            }
            result?.close()
        }
        return lives
    }

//MARK: - Note
    public func addNote(_ note: YZNoteModel) {
        let sql = "insert into FunnyNote (time,title) values(?,?)"
        self.databaseQueue.inTransaction { (db, rollback) in
            db?.executeUpdate(sql, withArgumentsIn: [NSNumber(integerLiteral: note.time),note.title])
        }
    }

    public func deleteNote(_ note: YZNoteModel) {
        let sql = "delete from FunnyNote where time = ?"
        self.databaseQueue.inTransaction { (db, rollback) in
            db?.executeUpdate(sql, withArgumentsIn: [NSNumber(integerLiteral: note.time)])
        }
    }
    
    public func updateNote(_ note: YZNoteModel) {
        let sql = "update FunnyNote set title = ? where time = ?"
        self.databaseQueue.inTransaction { (db, rollback) in
            db?.executeUpdate(sql, withArgumentsIn: [note.title,NSNumber(integerLiteral: note.time)])
        }
    }
    
    public func allNotes() ->[YZNoteModel]! {
        var notes = [YZNoteModel]()
        let sql = "select * from FunnyNote"
        self.databaseQueue.inTransaction { (db, rollback) in
            let result = db?.executeQuery(sql, withArgumentsIn: nil)
            while result!.next() {
                let title = result?.string(forColumn: "title")
                let time = result?.long(forColumn: "time")
                let note = YZNoteModel(noteTitle: title!, noteTime: time!)
                notes.append(note)
            }
            result?.close()
        }
        return notes
    }
}

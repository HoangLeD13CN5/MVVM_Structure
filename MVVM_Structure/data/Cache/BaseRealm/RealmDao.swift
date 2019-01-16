//
//  RealmDao.swift
//  ThoNguyen
//
//  Created by Hoang Le on 12/20/18.
//  Copyright © 2018 Hoang Le. All rights reserved.
//

import Foundation
import RealmSwift

protocol StandaloneCopy {
    associatedtype T
    
    func toStandalone() -> T
    
}

class RealmDao<T: Object> {
    
    class func realmInit() {
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
            try? FileManager.default.removeItem(at: fileURL)
        }
        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { _, oldSchemaVersion in
            if (oldSchemaVersion == 1) {
                
            }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    func findAll(_ type: T.Type) throws -> Results<T>? {
        let realm = try Realm()
        return realm.objects(type)
    }
    
    func count(_ type: T.Type) throws -> Int {
        let realm = try Realm()
        return realm.objects(type).count
    }
    
    func create(_ val: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(val)
        }
    }
    
    func createOrUpdate(_ val: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(val, update: true)
        }
    }
    
    func findById(_ type: T.Type,id:String)throws -> T? {
        let realm = try Realm()
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    func filter(_ type: T.Type, _ predicateFormat: String, _ args: Any...)throws -> Results<T>? {
        let realm = try Realm()
        return realm.objects(type).filter(NSPredicate(format: predicateFormat, argumentArray: args))
    }
    
    func sorted(_ type: T.Type, byKeyPath keyPath: String, ascending: Bool) throws -> Results<T>? {
        let realm = try Realm()
        return realm.objects(type).sorted(byKeyPath: keyPath, ascending: ascending)
    }
}

extension Results {
    func toArray<R: StandaloneCopy>(ofType: R.Type) -> [R.T] {
        typealias RM = R.T
        var array = [RM]()
        for i in 0 ..< count {
            if let result = self[i] as? R {
                array.append(result.toStandalone())
            }
        }
        
        return array
    }
}

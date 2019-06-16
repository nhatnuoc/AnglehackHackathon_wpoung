//
//  LoanObject.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/16/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SwifterSwift

class LoanObject: Object {

    @objc dynamic var createdDate: Date = Date()
    @objc dynamic var id: String = ""
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var repaymentDate: Date = Date()
    @objc dynamic var rate: Float = 0.2
    
    var dicRates: [Int: Float] = [1: 0.1, 3: 0.15, 6: 0.2, 12: 0.35]
    
    required init(createdDate: Date, amount: Float, term: Int) {
        super.init()
        self.createdDate = createdDate
        self.amount = amount
        let repaymentdate = createdDate.adding(.month, value: term)
        self.repaymentDate = repaymentdate
        self.rate = self.dicRates[term] ?? 0.0
        self.id = "\(createdDate.string(withFormat: "dd/MM/yyyy"))-\(repaymentdate.string(withFormat: "dd/MM/yyyy"))-\(Int.random(in: 0..<100000000))"
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    open override class func ignoredProperties() -> [String] { return [ "dicRates" ] }
    
}

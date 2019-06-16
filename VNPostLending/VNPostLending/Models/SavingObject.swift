//
//  SavingObject.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/16/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SavingObject: Object {
    @objc dynamic var createdDate: Date?
    @objc dynamic var amount: Int = 0
    @objc dynamic var rate: Float = 0.0
    
    init(createdDate: Date, amount: Int, rate: Float) {
        super.init()
        self.createdDate = createdDate
        self.amount = amount
        self.rate = rate
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init()
    }
}

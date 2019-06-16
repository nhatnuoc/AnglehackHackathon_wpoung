//
//  LoanDetailViewController.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/15/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class LoanDetailViewController: UIViewController {
    @IBOutlet weak var lblLoanID: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblRepaymentDate: UILabel!
    
    @IBAction func btnRepayment_Click(_ sender: UIButton) {
        let realm = try? Realm(configuration: realmConfig)
        try? realm?.write { [weak self] in
            let id = self?.loan.id ?? ""
            guard let obj = realm?.objects(LoanObject.self).filter("id = %@", id).first else { return }
            realm?.delete(obj)
        }
        self.showAlert("Success") { [weak self] in
            self?.navigationController?.popViewController()
        }
    }
    
    var loan: LoanObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Loan Detail"
        self.lblLoanID.text = self.loan.id
        self.lblAmount.text = "\(self.loan.amount.toDotString()) VND"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Float {
    func toDotString() -> String {
        let i = Int(self)
        return "\(i)".toDotString()
    }
}

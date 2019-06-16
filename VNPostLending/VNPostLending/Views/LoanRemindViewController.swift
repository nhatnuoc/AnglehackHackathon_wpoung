//
//  LoanRemindViewController.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/16/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit

class LoanRemindViewController: UIViewController {
    
    @IBOutlet weak var lblMessage: UILabel!
    
    var loan: LoanObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblMessage.text = "Your loan \(self.loan.amount.toDotString()) VND is about to be repaid. Please pay before 17h \(self.loan.repaymentDate.string(withFormat: "dd/MM")) so that there is no additional late payment fee and interest, ignore it if you paid"
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

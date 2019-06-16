//
//  SavingTableViewCell.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/15/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit

class SavingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: Any?) {
//        let dt = data as? LoanObject
//        self.lblRepaymentDate.text = dt?.repaymentDate?.string(withFormat: "dd/MM/yyyy")
//        self.lblCreatedDate.text = dt?.createdDate?.string(withFormat: "dd/MM/yyyy")
//        self.lblRate.text = "\((dt?.rate ?? 0) * 100)%"
//        let attrs = NSMutableAttributedString(string: "\(dt?.amount ?? 0)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)])
//        attrs.append(NSAttributedString(string: " VND", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]))
//        self.lblAmount.attributedText = attrs
    }

}

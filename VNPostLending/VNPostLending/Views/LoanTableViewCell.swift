//
//  LoanTableViewCell.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/15/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit

protocol LoanTableViewCellDelegate: class {
    func cell(_ cell: LoanTableViewCell, didClickRepaymennt btn: UIButton)
}

class LoanTableViewCell: UITableViewCell {
    
    weak var delegate: LoanTableViewCellDelegate?
    
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblRepaymentDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBAction func btnRepayment_Click(_ sender: UIButton) {
        self.delegate?.cell(self, didClickRepaymennt: sender)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: Any?) {
        let dt = data as? LoanObject
        self.lblRepaymentDate.text = dt?.repaymentDate.string(withFormat: "dd/MM/yyyy")
        self.lblCreatedDate.text = dt?.createdDate.string(withFormat: "dd/MM/yyyy")
        self.lblRate.text = "\(Int((dt?.rate ?? 0) * 100))%"
        let attrs = NSMutableAttributedString(string: "\((dt?.amount ?? 0).toDotString())", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25.0)])
        attrs.append(NSAttributedString(string: " VND", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]))
        self.lblAmount.attributedText = attrs
    }

}

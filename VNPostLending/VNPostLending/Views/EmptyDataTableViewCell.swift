//
//  EmptyDataTableViewCell.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/16/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit

protocol EmptyDataTableViewCellDelegate: class {
    func cell(_ cell: EmptyDataTableViewCell, didClickButton btn: UIButton)
}

class EmptyDataTableViewCell: UITableViewCell {
    
    var delegate: EmptyDataTableViewCellDelegate?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    
    @IBAction func btnOK_Click(_ sender: UIButton) {
        self.delegate?.cell(self, didClickButton: sender)
    }
    
    func setupData(_ data: Any?) {
        let dt = data as? [String: String]
        self.lblTitle.text = dt?["message"]
        self.btnOK.setTitle(dt?["action"], for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

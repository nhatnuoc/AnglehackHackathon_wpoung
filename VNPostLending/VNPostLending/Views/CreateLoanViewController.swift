//
//  CreateLoanViewController.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/15/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import RxSwift
import RxCocoa
import SwiftEntryKit
import SwifterSwift

class CreateLoanViewController: UIViewController {
    
    let dueDates: [[String: Any]] = [
        ["name": "1 Month", "value": 1, "rate": 0.1],
        ["name": "3 Months", "value": 3, "rate": 0.15],
        ["name": "6 Months", "value": 6, "rate": 0.2],
         ["name": "12 Months", "value": 12, "rate": 0.35]
    ]
    var term: Int = 1
    
    @IBOutlet weak var txtAmount: UITextField! {
        didSet {
            self.txtAmount.delegate = self
        }
    }
    @IBOutlet weak var txtDueDate: UITextField! {
        didSet {
            self.txtDueDate.delegate = self
        }
    }
    
    @IBAction func btnCreate_Click(_ sender: UIButton) {
        self.view.endEditing(true)
        let realm = try? Realm(configuration: realmConfig)
        let amount: Float = Float(self.txtAmount.text?.replacingOccurrences(of: ".", with: "") ?? "") ?? 0.0
        try? realm?.write { [weak self] in
            guard let obj = realm?.create(LoanObject.self) else { return }
            let createdDate = Date()
            let term = self?.term ?? 0
            obj.createdDate = Date()
            obj.amount = amount
            let repaymentdate = createdDate.adding(.month, value: term)
            obj.repaymentDate = repaymentdate
            obj.rate = obj.dicRates[term] ?? 0.0
            obj.id = "\(createdDate.string(withFormat: "dd/MM/yyyy"))-\(repaymentdate.string(withFormat: "dd/MM/yyyy"))-\(Int.random(in: 0..<100000000))"
        }
        self.showAlert("Success") { [weak self] in
            self?.navigationController?.popViewController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtDueDate.text = "1 Month"
    }

}

extension CreateLoanViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let txt = textField.text ?? ""
        let newText = "\(txt)\(string)".toDotString()
        textField.text = newText
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == self.txtDueDate {
            var attrs = EKAttributes()
            attrs.position = EKAttributes.Position.bottom
            attrs.displayDuration = EKAttributes.DisplayDuration.infinity
            attrs.positionConstraints = EKAttributes.PositionConstraints.init(verticalOffset: 0.0, size: EKAttributes.PositionConstraints.Size(width: .offset(value: 0.0), height: .constant(value: 250)), maxSize: EKAttributes.PositionConstraints.Size(width: .offset(value: 0.0), height: .constant(value: 250)))
            attrs.screenBackground = .color(color: UIColor(hexString: "000000", transparency: 0.4)!)
            attrs.roundCorners = .top(radius: 10.0)
            attrs.entryInteraction = .absorbTouches
            attrs.screenInteraction = .dismiss
            let items = self.dueDates.compactMap { (item) -> String? in
                return "\((item["name"] as? String) ?? "") - \(Int(((item["rate"] as? Double) ?? 0) * 100))%"
            }
            let vc = ListActionSheetController.instance(withItems: items)
            vc.didSelect = { [weak self] index, text in
                self?.term = self?.dueDates[index]["value"] as? Int ?? 1
                self?.txtDueDate.text = text
                SwiftEntryKit.dismiss()
            }
            SwiftEntryKit.display(entry: vc, using: attrs)
            return false
        }
        return true
    }
}

extension String {
    func toDotString() -> String {
        let str = self.replacingOccurrences(of: ".", with: "")
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        let number = NSNumber(value: Float(str)!)
//        guard number != nil else {
//            return ""
//        }
        let faNumber = formatter.string(from: number)
        return faNumber ?? ""
    }
}

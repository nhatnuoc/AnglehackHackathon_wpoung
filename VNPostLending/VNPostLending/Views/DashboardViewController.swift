//
//  DashboardViewController.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/15/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RealmSwift
import Realm

let realmConfig = Realm.Configuration.defaultConfiguration
let storyboard = UIStoryboard(name: "Main", bundle: nil)

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items: [[String: Any]] = [
        [
            "name": "Loan list",
            "cellID": "\(LoanTableViewCell.self)",
            "items": [
            ]
        ],
        [
            "name": "Saving list",
            "cellID": "\(SavingTableViewCell.self)",
            "items": [
            ]
        ]
    ]
    let realm: Realm? = try? Realm(configuration: realmConfig)
    var loansNotificationToken: NotificationToken?
    var savingsNotificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Dashboard"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.fetchData()
    }
    
    func fetchData() {
        self.loansNotificationToken = self.realm?.objects(LoanObject.self).observe({ [weak self] (change) in
            switch change {
            case .update(let results, deletions: _, insertions: _, modifications: _), .initial(let results):
                if results.count > 0 {
                    self?.items[0]["cellID"] = "\(LoanTableViewCell.self)"
                    self?.items[0]["items"] = Array(results)
                } else {
                    self?.items[0]["cellID"] = "\(EmptyDataTableViewCell.self)"
                    self?.items[0]["items"] = [["message": "You don't have any loans", "action": "Create loan"]]
                }
                self?.tableView.reloadSections([0], animationStyle: .automatic)
            case .error(_):
                ()
            }
        })
        self.savingsNotificationToken = self.realm?.objects(SavingObject.self).observe({ [weak self] (change) in
            switch change {
            case .update(let results, deletions: _, insertions: _, modifications: _), .initial(let results):
                if results.count > 0 {
                    self?.items[1]["cellID"] = "\(SavingTableViewCell.self)"
                    self?.items[1]["items"] = Array(results)
                } else {
                    self?.items[1]["cellID"] = "\(EmptyDataTableViewCell.self)"
                    self?.items[1]["items"] = [["message": "You don't have any savings", "action": "Create saving"]]
                }
                self?.tableView.reloadSections([1], animationStyle: .automatic)
            case .error(_):
                ()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueID = segue.identifier ?? ""
        if segueID == "\(LoanDetailViewController.self)Segue" {
            let vc = segue.destination as! LoanDetailViewController
            let cell = sender as! LoanTableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            vc.loan = (self.items[0]["items"] as? [LoanObject])?[indexPath!.row]
        }
    }
    
    deinit {
        self.loansNotificationToken?.invalidate()
        self.loansNotificationToken = nil
        self.savingsNotificationToken?.invalidate()
        self.savingsNotificationToken = nil
    }
    
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items[section]["items"] as? [Any])?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = self.items[indexPath.section]["cellID"] as! String
        let its = (self.items[indexPath.section]["items"] as? [Any])?[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? LoanTableViewCell {
            cell.setupData(its)
            cell.delegate = self
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SavingTableViewCell {
            cell.setupData(its)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EmptyDataTableViewCell
        cell.delegate = self
        cell.setupData(its)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Loan list" : "Saving list"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

extension DashboardViewController: EmptyDataTableViewCellDelegate {
    func cell(_ cell: EmptyDataTableViewCell, didClickButton btn: UIButton) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "\(CreateLoanViewController.self)Segue", sender: nil)
        } else {
            self.performSegue(withIdentifier: "\(CreateSavingViewController.self)Segue", sender: nil)
        }
    }
}

extension DashboardViewController: LoanTableViewCellDelegate {
    func cell(_ cell: LoanTableViewCell, didClickRepaymennt btn: UIButton) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        guard let item = (self.items[indexPath.section]["items"] as? [Any])?[indexPath.row] as? LoanObject else { return }
        try? self.realm?.write { [weak self] in
            let id = item.id
            guard let obj = self?.realm?.objects(LoanObject.self).filter("id = %@", id).first else { return }
            self?.realm?.delete(obj)
        }
    }
}

extension UIViewController {
    func showAlert(_ message: String?, okHandler: (() -> Void)?) {
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            okHandler?()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}

//
//  ListActionSheetController.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/16/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListActionSheetController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(cellWithClass: UITableViewCell.self)
        }
    }
    
    var didSelect: ((_ index: Int) -> Void)?
    let items: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    let disposeBag = DisposeBag()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.items.bind(to: self.tableView.rx.items(cellIdentifier: "\(UITableViewCell.self)")) { index, model, cell in
            cell.textLabel?.text = model
        }.disposed(by: self.disposeBag)
        self.tableView.rx.itemSelected.bind { [weak self] (indexPath) in
            self?.didSelect?(indexPath.row)
        }.disposed(by: self.disposeBag)
    }
    
    class func instance(withItems items: [String]) -> ListActionSheetController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: ListActionSheetController.self)
        vc?.items.accept(items)
        return vc!
    }

}

//
//  ViewController.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    let label = UILabel()
    var disposeBag = DisposeBag()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        binding()
    }
    
    func binding() {
        viewModel.items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map({ data in
                "\(data)를 클릭했습니다!!"
            })
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func viewConfig() {
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.backgroundColor = .lightGray
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}

class ViewModel {
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
}

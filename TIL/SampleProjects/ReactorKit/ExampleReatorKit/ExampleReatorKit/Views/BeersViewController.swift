//
//  BeersViewController.swift
//  ExampleReatorKit
//
//  Created by JD_MacMini on 2022/03/02.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class BeersViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    
    private let beersTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BeersTableViewCell.self, forCellReuseIdentifier: BeersTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    private func viewConfig() {        
        view.backgroundColor = .red
        reactor = BeersViewReactor()
        view.addSubview(beersTableView)
        beersTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind(reactor: BeersViewReactor) {
        //rx.viewWillAppear
        Observable.just(Void())
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.items }
            .bind(to: beersTableView.rx.items(
                cellIdentifier: BeersTableViewCell.identifier,
                cellType: BeersTableViewCell.self)) { row, item, cell in
                    cell.configure(with: item)
                }.disposed(by: disposeBag)
    }
}

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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BeersTableViewCell.self, forCellReuseIdentifier: BeersTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    private func viewConfig() {
        view.backgroundColor = .systemBackground
        reactor = BeersViewReactor()
        view.addSubview(beersTableView)
        beersTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind(reactor: BeersViewReactor) {
        // Action 1. viewDidLoad
        Observable.just(Void())
            .map { Reactor.Action.updateBeers }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Action 2. tableview scrolling -> pagination
        beersTableView.rx.contentOffset
            .filter { [weak self] in
                print("content offset")
                guard let self = self else { return false }
                // 시작하자마자 pagination 되는 것을 방지
                guard self.beersTableView.frame.height > 0 else { return false }
                print("pagination")
                return $0.y + self.beersTableView.frame.height > self.beersTableView.contentSize.height - 100
            }.map { _ in Reactor.Action.pagination }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // state: items bind to table view
        reactor.state
            .map { $0.items }
            .bind(to: beersTableView.rx.items(
                cellIdentifier: BeersTableViewCell.identifier,
                cellType: BeersTableViewCell.self)) { row, item, cell in
                    cell.configure(with: item)
                }.disposed(by: disposeBag)
    }
}

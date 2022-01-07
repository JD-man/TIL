//
//  ReactiveViewController.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/05.
//

import UIKit
import RxSwift
import SnapKit
import RxRelay

struct SampleData {
    var user: String
    var age: Int
    var rate: Double
}

class ReactiveViewModel {
    var data = [
        SampleData(user: "JD", age: 11, rate: 1.1),
        SampleData(user: "DH", age: 12, rate: 2.2),
        SampleData(user: "JDH", age: 13, rate: 3.3),
    ]
    
    var list = PublishRelay<[SampleData]>()
    
    func fetchData() {
        list.accept(data)
    }
    
    func filterData(query: String) {
        let result = query != "" ? data.filter { $0.user.contains(query) } : data
        list.accept(result)
    }
}

class ReactiveViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()
    
    var disposeBag = DisposeBag()
    let viewModel = ReactiveViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // viewModel data -> TableView ??
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) {
                (row, element, cell) in
                cell.textLabel?.text = "\(element.user): \(element.age)세 (\(element.rate))"
            }.disposed(by: disposeBag)
        
        var touchNumber = 0
        resetButton.rx.tap
            .asDriver()
            .map { touchNumber += 1 }
            .throttle(.seconds(2))
            .drive { _ in
                print("\(touchNumber)")
            }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe {
                print($0)
            }.disposed(by: disposeBag)
    }
    
    func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().offset(-20)
        }
        resetButton.backgroundColor = .red
        
    }
    
    func reactiveTest() {
        
        var apple = 1
        var banana = 2
        
        print(apple + banana)
        
        apple = 10
        banana = 10
        
        let a = BehaviorSubject(value: 1)
        let b = BehaviorSubject(value: 2)
        
        Observable.combineLatest(a, b) { $0 + $1 }
        .subscribe {
            print($0.element ?? 0)
        }
        .disposed(by: disposeBag)
        
        a.onNext(50)
        b.onNext(10)
    }
}

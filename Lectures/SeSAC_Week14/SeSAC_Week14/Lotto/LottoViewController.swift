//
//  LottoViewController.swift
//  SeSAC_Week14
//
//  Created by JD_MacMini on 2021/12/28.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let viewModel = LottoViewModel()
    
    // 1~7, 일자, 당첨 금액
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.lotto1.bind {
            self.label1.text = "\($0)"
        }
        viewModel.lotto2.bind {
            self.label2.text = "\($0)"
        }
        viewModel.lotto3.bind {
            self.label3.text = "\($0)"
        }
        viewModel.lotto4.bind {
            self.label4.text = "\($0)"
        }
        viewModel.lotto5.bind {
            self.label5.text = "\($0)"
        }
        viewModel.lotto6.bind {
            self.label6.text = "\($0)"
        }
        viewModel.lotto7.bind {
            self.label7.text = "\($0)"
        }
        
        viewModel.lottoMoney.bind {
            self.moneyLabel.text = $0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchLottoAPI(678)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.viewModel.fetchLottoAPI(700)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            $0.backgroundColor = .lightGray
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
        
        view.addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
        
    }
}

//
//  SnapDetailViewController.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/14.
//

import UIKit
import SnapKit
import Firebase

class SnapDetailViewController: UIViewController {
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "12,341원"
        label.backgroundColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel = UILabel()
    
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("클릭", for: .normal)
        button.addTarget(self, action: #selector(activateButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let pushActivateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("푸시", for: .normal)
        button.addTarget(self, action: #selector(pushActivateButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let redView = UIView()
    
    let blueView = UIView()
    
    let firstSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    
    let secondSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    
    let thirdSquareView: SquareBoxView = {
        let view = SquareBoxView()        
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    @objc func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "우왕굳"
        present(vc, animated: true, completion: nil)
    }
    
    @objc func pushActivateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "우왕굳 푸시"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 로그아웃 등 토큰 교환이 필요한 경우 installation 삭제를 이용한다
        Installations.installations().delete { error in
          if let error = error {
            print("Error deleting installation: \(error)")
            return
          }
          print("Installation deleted");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        view.addSubview(stackView)
        
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.firstSquareView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 0.35) { [weak self] in
                self?.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 0.35) { [weak self] in
                    self?.thirdSquareView.alpha = 1
                }
            }

        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(0.8)
            $0.height.equalTo(80)
        }
//        [pushActivateButton, activateButton, moneyLabel, descriptionLabel, redView].forEach {
//            view.addSubview($0)
//        }
//
//        moneyLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(view)
//            make.centerY.equalTo(view)
//            make.width.equalTo(300)
//            make.height.equalTo(80)
//        }
//
//        activateButton.snp.makeConstraints {
//            $0.leadingMargin.equalTo(view).offset(50)
//            $0.trailingMargin.equalTo(view).offset(-50)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//            $0.height.equalTo(view).multipliedBy(0.1)
//        }
//
//        pushActivateButton.snp.makeConstraints {
//            $0.leading.equalTo(activateButton)
//            $0.trailing.equalTo(activateButton)
//            $0.bottom.equalTo(activateButton).offset(-100)
//            $0.top.equalTo(activateButton).offset(-100)
//        }
//
//        redView.backgroundColor = .red
//        redView.snp.makeConstraints { make in
////            make.top.equalTo(view)
////            make.leading.equalTo(view)
////            make.trailing.equalTo(view)
////            make.bottom.equalTo(view)
//
//            // inset은 상하좌우 감소
//            make.edges.equalToSuperview().inset(100)
//        }
//
//        redView.snp.updateConstraints { make in
//            make.bottom.equalTo(-500)
//        }
//
//        blueView.backgroundColor = .blue
//        redView.addSubview(blueView)
//
//        blueView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().offset(50)
//        }
        
    }
}

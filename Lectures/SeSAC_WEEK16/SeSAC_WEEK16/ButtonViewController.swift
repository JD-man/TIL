//
//  ButtonViewController.swift
//  SeSAC_WEEK16
//
//  Created by JD_MacMini on 2022/01/13.
//

import UIKit

// Top Level??
//print("Hello")

class ButtonViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.center = view.center
        view.addSubview(button)
        button.configuration = .baseStyle()
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        //formatStyle()
        print(deferExample())
    }
    
    @objc private func buttonClicked() {
        button.configuration?.showsActivityIndicator = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.button.configuration?.showsActivityIndicator = false
//            let detailVC = DetailViewController()
//            self.present(detailVC, animated: true, completion: nil)
            
            let picker = UIColorPickerViewController()
            picker.delegate = self
            if let presentationController =  picker.presentationController
                as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large()]
                presentationController.prefersGrabberVisible = true
                presentationController.preferredCornerRadius = 20
            }
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
    func formatStyle() {
        let value = Date()
        print(value)
        print(value.formatted())
        print(value.formatted(date: .complete, time: .standard))
        
        let locale = Locale(identifier: "ko-KR")
        let result = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
        print(result)
        
        let result2 = value.formatted(.dateTime.day().month(.twoDigits).year())
        print(result2)
        
        print(129387123987.formatted())
        print(123987132987.formatted(.currency(code: "krw")))
        
        let arr = ["A","B","C"].formatted()
        print(arr)
    }
    
    func deferExample() -> String {
        var nickname = "조동"
        
        defer {
            print("defer")
            nickname = "우왕굳"
        }
        
        return nickname
        // defer는 항상 스코프의 끝에서 실행됨.
    }
    
    func deferExample2() -> String? {
        var nickname: String? = "조동2"
        
        defer {
            // 리턴하고 리소스를 정리할 때 사용가능.
            nickname = nil
        }
        
        return nickname
    }
    
    func deferExample3() {
        defer {
            print("example1")
        }
        
        defer {
            print("example2")
        }
        
        defer {
            print("example3")
            defer {
                print("example4")
            }
        }
    }
}

extension UIButton.Configuration {
    static func baseStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "버튼 타이틀"
        configuration.subtitle = "버튼 서브 타이틀"
        configuration.titleAlignment = .center
        configuration.image = UIImage(systemName: "star.fill")
        configuration.baseBackgroundColor = .systemPink
        configuration.baseForegroundColor = .systemBackground
        configuration.cornerStyle = .large
        configuration.imagePadding = 8
        return configuration
    }
}

extension ButtonViewController: UIColorPickerViewControllerDelegate {
    
    public func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.animateChanges {
                presentationController.selectedDetentIdentifier = .medium
            }
        }
        view.backgroundColor = color
    }
}

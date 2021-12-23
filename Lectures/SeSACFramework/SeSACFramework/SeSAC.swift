//
//  SeSAC.swift
//  SeSACFramework
//
//  Created by JD_MacMini on 2021/12/23.
//
import UIKit
import WebKit

// 외부모듈에서 클래스는 open, public로만 가져오기 가능.
// open은 상속 및 서브클래스 가능. public은 override도 불가
open class OpenSeSAC: UIViewController {
    
    open var name: String = "JD"
    open func openFunction() {
        
    }
    
    public enum TransitionStyle {
        case present, push
    }
    
    public func presentWebViewController(url: String, transitionStyle: TransitionStyle, vc: UIViewController) {
        let webViewController = WebViewController()
        webViewController.url = url
        switch transitionStyle {
        case .present:
            vc.present(webViewController, animated: true, completion: nil)
        case .push:
            vc.navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}

class WebViewController: UIViewController, WKUIDelegate {
    var url: String = "https://www.apple.com"
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

public class PublicSeSAC: UIViewController {
    var name: String = "JD"
    func publicFunction() {
        
    }
}

// 이 밑으로 다른 모듈 클래스 상속 등은 안됨. 접근제어자 아무거도 안쓰면 internal임.
// 다른 모듈이 아니라면 internal은 다른 파일에서도 사용할 수 있다.
internal class InternalSeSAC: UIViewController {
    
}

fileprivate class FilePricateSeSAC: UIViewController {
    
}

private class PrivateSeSAC: UIViewController {
    
}

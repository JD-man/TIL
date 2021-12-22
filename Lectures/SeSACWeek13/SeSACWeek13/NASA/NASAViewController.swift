//
//  NASAViewController.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/22.
//

import UIKit

class NASAViewController: BaseViewController {
    
    let label = UILabel()
    let imageView = UIImageView()
    
    var session: URLSession!
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = "\(result * 100) / 100"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        session.invalidateAndCancel() // 리소스 정리: 그냥 다 정리. 실행중인 태스크있어도 무시함
        session.finishTasksAndInvalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buffer = Data()
        request()
    }
    
    override func configure() {        
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFill
        
        label.textAlignment = .center
        label.backgroundColor = .magenta
        label.textColor = .systemTeal
        label.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(label)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_2980.jpg")
        // shared는 completion handler만 사용가능.
        // 10MB 정도 기준으로 dataTask를 쓸지 downloadTask를 쓸지 정한다.
        
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = false
//        URLSession(configuration: configuration).dataTask(with: url!).resume()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url!).resume()
    }
}


extension NASAViewController: URLSessionDataDelegate {
    // 서버에서 최초로 응답 받은 경우 호출(상태코드)
    // 왜 최초? 크기가 큰 데이터의 경우 나눠서 받기 때문
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        //print(#function)
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            print(response)
            total = Double(response.value(forHTTPHeaderField: "Content-Length") ?? "0") ?? 0
            return .allow // didRecieve data 실행
        }
        else {
            return .cancel // didCompleteWithError 실행
        }
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //print(data)
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("오류 발생", error)
        }
        else {
            print("성공")
            // Buffer가 모두 채워졌을때 이미지로 변환
            guard let buffer = buffer else {
                print("buffer error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
}

//
//  ConcurrencyViewController.swift
//  SeSAC_WEEK16
//
//  Created by JD_MacMini on 2022/01/12.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
        let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
        let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func basicButtonClicked(_ sender: UIButton) {
        
        print("Hello World")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("Bye World")
        
    }
    
    
    @IBAction func mainAsyncButtonClicked(_ sender: UIButton) {
        print("Hello World")
        
//        DispatchQueue.main.async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
//        DispatchQueue.main.sync {
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1 ... 100 {
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        
        
        print("Bye World")
    }
    
    @IBAction func globalQueueButtonClicked(_ sender: UIButton) {
        
        print("Hello World")
        
        let queue = DispatchQueue(label: "CustomQueue",
                                  qos: .userInteractive,
                                  attributes: .concurrent)
        
        queue.async {
            print("CustomQueue async")
        }
        
        // global sync는 실질적으로는 메인 스레드에서 실행
//        DispatchQueue.global().sync {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1 ... 100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        
//        DispatchQueue.global().sync {
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
        
        print("Bye World")
    }
    
    
    @IBAction func globalQoS(_ sender: UIButton) {
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
    }
    
    @IBAction func dispatchGroupButtonClicked(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("notify")
            self.view.backgroundColor = .systemPink
        }
    }
    
    
    @IBAction func urlsessionDispatchGroup(_ sender: UIButton) {
        let group = DispatchGroup()
        
        group.enter()
        self.request(url: self.url1) { image in
            print("image1")
            group.leave()
        }

        group.enter()
        self.request(url: self.url2) { image in
            print("image2")
            group.leave()
        }
        
        
        group.enter()
        self.request(url: self.url3) { image in
            print("image3")
            group.leave()
        }
        
        
        group.notify(queue: .main) {
            print("완료")
        }
    }
    
    
    func request(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    
    @IBAction func asyncAwait(_ sender: UIButton) {
        Task {
            do {
                let image1 = try await newRequest(url: url1)
                let image2 = try await newRequest(url: url2)
                let image3 = try await newRequest(url: url3)
                
                imageView1.image = image1
                imageView2.image = image2
                imageView3.image = image3
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func raceCondition(_ sender: UIButton) {
        var nickname = "JD"
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "1"
            print("First: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "2"
            print("Second: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("notify: \(nickname)")
        }
        
    }
    
    
    func newRequest(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.statusCodeError
        }
        
        guard let image = UIImage(data: data) else {
            throw APIError.notImage
        }
        
        return image
    }
}

enum APIError: Error {
    case statusCodeError
    case notImage
}

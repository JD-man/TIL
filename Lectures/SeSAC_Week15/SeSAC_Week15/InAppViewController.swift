//
//  InAppViewController.swift
//  SeSAC_Week15
//
//  Created by JD_MacMini on 2022/01/07.
//

import UIKit
import StoreKit

class InAppViewController: UIViewController {

    // 1. 인앱 상품ID 정의
    var productIdentifiers: Set<String> = [
        "com.JD-man.item1",
        "com.JD-man.item2",
        "com.JD-man.item3"
    ]
    
    // 3-1. 인앱 상품 배열
    var productArray = Array<SKProduct>()
    var product: SKProduct?

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProductData()
        
        view.addSubview(button)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // 4. 구매 버튼 클릭
    @objc func buttonClicked() {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
//        SKPaymentQueue.default().add(self)
        
    }
    
    // 2. productIdentifiers에 정의된 상품ID에 대한 정보 가져오기 및 사용자의 디바이스가 인앱결제가 가능한지 여부 확인
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            let request = SKProductsRequest(productIdentifiers: productIdentifiers)
            request.delegate = self
            request.start()
        }
        else {
            print("In App Purchase Not Enabled")
        }
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        // SandBox: “https://sandbox.itunes.apple.com/verifyReceipt%E2%80%9D"
        // iTunes Store : “https://buy.itunes.apple.com/verifyReceipt%E2%80%9D"
        
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print(receiptString)
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}



extension InAppViewController: SKProductsRequestDelegate {
    // 3. 인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        if products.count > 0 {
            for i in products {
                productArray.append(i)
                product = i // 옵션
                //dump(("product: ", i.localizedTitle))
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription)
            }
        }
        else {
            
        }
        
    }
}

extension InAppViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased: // 구매 승인 이후에 영수증 검증
                print("Transaction Approved. \(transaction.payment.productIdentifier)")
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
            case .failed: // 실패 토스트, transaction
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            @unknown default:
                break
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print(#function)
    }
}

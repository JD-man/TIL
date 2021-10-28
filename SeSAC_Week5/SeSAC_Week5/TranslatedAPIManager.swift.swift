//
//  TranslatedAPIManager.swift.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslatedAPIManager {
    static let shared = TranslatedAPIManager()
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchTranslateData(text: String, result: @escaping CompletionHandler) {
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.NAVER_ID,
            "X-Naver-Client-Secret" : APIKey.NAVER_SECRET
        ]
        
        let parameters = [
            "source" : "ko",
            "target" : "en",
            "text" : text
        ]
        
        
        // Alamofire는 validate로 200~299까지 성공적인 코드로 받는다. 수정할 수 있다
        AF.request(Endpoint.papagoURL, method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200 ... 500)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    // validate로 API 문서에서 지정한 오류코드의 범위까지 정해주면 문서의 에러메세지도 JSON으로 받는다.
                    // 에러처리는 열거형으로 처리하거나 텍스트로 표시한다.
                    
                    let json = JSON(data)
                    
                    // status가 안날라오면 서버오류라고 생각하고 진행
                    let code = response.response?.statusCode ?? 500
                    result(code, json)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

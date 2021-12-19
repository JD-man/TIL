//
//  VisionAPIManager.swift
//  SeSAC_Week5
//
//  Created by JD_MacMini on 2021/10/27.
//

import UIKit.UIImage
import Alamofire
import SwiftyJSON

class visionAPIManager {
    static let shared = visionAPIManager()
    
    func fetchFaceData(image: UIImage, result: @escaping (Int, JSON) -> ()) {
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.KAKAO_KEY,
            
            // 라이브러리 내에서 Content-Type을 추가해서 없어도 개발은 된다.
            // 하지만 제대로 알고 있어야 한다.
            "Content-Type" : "multipart/form-data"
        ]
        
        // UIImage를 Data 타입으로 변환(바이너리 타입)
        guard let imageData = image.pngData() else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: Endpoint.visionURL, headers: headers)
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


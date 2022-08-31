//
//  NewsResponse.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable, Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.source == rhs.source
    }
    
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Codable, Equatable {
    let name: String?
}

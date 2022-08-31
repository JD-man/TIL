//
//  NewsListCell.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import SwiftUI

struct NewsListCell: View {
    
    let model: NewsListCellModel
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .frame(width: 100, height: 100, alignment: .center)
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text(model.title)
                Text(model.description)
                    .lineLimit(3)
            })
        }.padding()
    }
}

extension NewsListCell {
    struct NewsListCellModel: Identifiable {
        var id = UUID()
        
        let title: String
        let description: String
        let imageURL: String?
    }
}

struct NewsListCell_Previews: PreviewProvider {
    static var previews: some View {
        let mock = NewsListCell.NewsListCellModel(
            title: "Mock Title",
            description: "Mock Descrpition",
            imageURL: nil
        )
        NewsListCell(model: mock)
    }
}

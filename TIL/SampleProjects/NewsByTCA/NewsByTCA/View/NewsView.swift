//
//  NewsView.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import SwiftUI
import ComposableArchitecture

struct NewsView: View, TCAViewType {
  typealias State = NewsComponent.State
  typealias Action = NewsComponent.Action
  
  var store: Store<NewsComponent.State, NewsComponent.Action>
  
  var body: some View {
    WithViewStore(store) { store in
      NavigationView {
        Button("시작") {
          store.send(.onAppear)
        }.frame(width: 100, height: 100, alignment: .center)
        
        List {
          ForEach(store.articles.map {
            NewsListCell.NewsListCellModel(
              title: $0.title ?? "",
              description: $0.description ?? "",
              imageURL: $0.urlToImage
            )
          }) {
            NewsListCell(model: $0)
          }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("우왕")
        .background(.red)
      }
    }
  }
}

struct NewsView_Previews: PreviewProvider {
  static var previews: some View {
    let component = NewsComponent()
    NewsView(store: Store<NewsComponent.State, NewsComponent.Action>(initialState: .init(), reducer: component.reducer, environment: .init(articles: { _ in
      return []
    })))
  }
}



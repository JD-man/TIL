//
//  NewsViewBuilder.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import SwiftUI
import ComposableArchitecture

enum NewsViewBuilder: ViewBuilderType {
  case news
  
  var view: some View {
    switch self {
    case .news:
      return makeNewsView()
    }
  }
}

extension NewsViewBuilder {
  @ViewBuilder
  private func makeNewsView() -> some View {
    let component = NewsComponent()
    NewsView(
      store: Store<NewsComponent.State, NewsComponent.Action>(
        initialState: .init(),
        reducer: component.reducer,
        environment: .init(articles: { country in
          return try await repo().fetch(country: country)
        })
      )
    )
  }
}

final class repo {
  func fetch(country: NewsCountry) async throws -> [Article] {
    let url = URLs.rootURL + URLs.topHeadlines
    var components = URLComponents(string: url)!
    components.queryItems = [
      URLQueryItem(name: "apikey", value: URLs.apiKey),
      URLQueryItem(name: "country", value: country.rawValue)
    ]
    let (data, _) = try await URLSession.shared.data(from: components.url!)
    do {
      let response = try JSONDecoder().decode(NewsResponse.self, from: data)
      return response.articles
    } catch {
      print(error)
      return []
    }
  }
}

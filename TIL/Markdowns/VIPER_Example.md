# VIPER 예제 날씨앱
- [Github](https://github.com/JD-man/TIL/tree/main/TIL/SampleProjects/WeatherByVIPER/WeatherByVIPER)

## Router
```swift
// AppRouter.swift
import UIKit

final class AppRouter: RouterType {
    var navigationController: UINavigationController
    var childRouter: [RouterType] = []
    
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        startWithWeatherRouter()
    }
    
    private func startWithWeatherRouter() {
        let weatherRouter = WeatherRouter(nav: navigationController, parentRouter: self)
        childRouter.append(weatherRouter)        
        weatherRouter.start()
    }
}

// SceneDelegate.swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appRouter: RouterType?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        let appNav = UINavigationController()
        appRouter = AppRouter(nav: appNav)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = appNav
        
        appRouter?.start()
        window?.makeKeyAndVisible()        
    }

    // ...
}

// WeatherRouter.swift
final class WeatherRouter: RouterType {
    var navigationController: UINavigationController
    weak var parentRouter: RouterType?
    
    init(nav: UINavigationController, parentRouter: RouterType) {
        self.navigationController = nav
        self.parentRouter = parentRouter
    }
    
    func start() {
        pushWeatherViewController()
    }
    
    func pushWeatherViewController() {
        let weatherVC = WeatherViewController(
            presenter: WeatherPresenter(
                router: self,
                interactor: WeatherInteractor())
        )
        navigationController.pushViewController(weatherVC, animated: true)
    }
}
```

- AppRouter를 만들고 SceneDelegate에서 rootViewController와 함께 설정해준다.
- AppRouter에서 WeatherRouter를 시작시키고 WeatherRouter에서 의존성주입과 함께 첫화면을 설정한다.

---

## View
```swift
// WeatherViewController.swift

var presenter: WeatherPresenter
private var disposeBag = DisposeBag()

init(presenter: WeatherPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
}

private func binding() {
    let output = presenter.transform()
    
    Observable.just(())
        .bind(to: presenter.input.viewDidLoad)
        .disposed(by: disposeBag)
    
    output.tempDriver
        .drive(temperatureLabel.rx.text)
        .disposed(by: disposeBag)
    
    output.humidityDriver
        .drive(humidityLabel.rx.text)
        .disposed(by: disposeBag)
    
    output.speedDriver
        .drive(speedLabel.rx.text)
        .disposed(by: disposeBag)
    
    output.iconDriver
        .drive(iconImageView.rx.iconImage)
        .disposed(by: disposeBag)
}
```

- View쪽에 presenter 프로퍼티를 만들고 init을 통한 의존성 주입을 준비한다.
- binding 메서드에는 presenter를 통한 input/output 형식으로 만들었다.
- viewDidLoad input이 실행되면 presenter는 interactor를 통해 response를 받는다.
- response를 각 날씨요소별로 output으로 이용해 뷰와 연결한다.

---

## Presenter
```swift
// WeatherPresenter.swift
final class WeatherPresenter: WeatherPresenterType {
    
    private var disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
    }
    
    struct Output {
        let tempDriver: Driver<String>
        let humidityDriver: Driver<String>
        let speedDriver: Driver<String>
        let iconDriver: Driver<String>
    }
    
    var router: RouterType
    var interactor: WeatherInteractorType
    var weatherResponseRelay = PublishRelay<WeatherResponseModel>()
    
    var input = Input()
    
    init(router: RouterType, interactor: WeatherInteractorType) {
        self.router = router
        self.interactor = interactor
    }
    
    func transform() -> Output {
        
        input.viewDidLoad
            .withUnretained(self)
            .flatMapLatest { (presenter, signal) in
                presenter.interactor.fetchWeatherData() }
            .catch {
                print("error: ", $0)
                return Observable.empty() }
            .bind(to: weatherResponseRelay)
            .disposed(by: disposeBag)
        
        let tempDriver = weatherResponseRelay.map { "온도: \($0.main.temp)" }.asDriver(onErrorJustReturn: "")
        let humidityDriver = weatherResponseRelay.map { "습도: \($0.main.humidity)" }.asDriver(onErrorJustReturn: "")
        let speedDriver = weatherResponseRelay.map { "풍속: \($0.wind.speed)" }.asDriver(onErrorJustReturn: "")
        let iconDriver = weatherResponseRelay.map { $0.weather[0].icon }.asDriver(onErrorJustReturn: "")
        
        return Output(
            tempDriver: tempDriver,
            humidityDriver: humidityDriver,
            speedDriver: speedDriver,
            iconDriver: iconDriver
        )
    }
}
```

- transform 메서드를 통해 output을 리턴한다.
- interactor를 이용한 날씨 API 통신을 통해 response를 받고 각 날씨 정보별로 output을 만든다.
- 이 과정에서 중계해줄 relay를 만들었다.

---

## Interactor
```swift
import Foundation
import RxSwift
import Moya

final class WeatherInteractor: WeatherInteractorType {
    let provider = MoyaProvider<WeatherTarget>()
    
    func fetchWeatherData() -> Single<WeatherResponseModel> {
        let parameters = WeatherRequestModel().toParameter()
        return Single<WeatherResponseModel>.create { [weak self] single in
            self?.provider.request(.getWeatherInfo(parameters: parameters), completion: { result in
                switch result {
                case .success(let response):
                    guard let model = try? response.map(WeatherResponseModel.self) else { return }
                    single(.success(model))
                case .failure(let error):
                    print(error)
                    single(.failure(error))
                }
            })
            return Disposables.create()
        }
    }
}
```
- Moya를 사용했으며 Single을 반환한다. 간단

---

## Entity
```swift
// WeatherRequestModel.swift
struct WeatherRequestModel {
    let lat: Double = 37.48433605595456
    let lon: Double = 126.92985099999653
    let units: String = "metric"
}

extension WeatherRequestModel {
    func toParameter() -> [String: Any] {
        return [
            "lat": lat,
            "lon": lon,
            "units": units,
            "appid": URLComponents.key
        ]
    }
}

// WeatherResponseModel.swift
struct WeatherResponseModel: Codable {
    let main: WeatherMain
    let wind: WeatherWind
    let weather: [WeatherDetail]
}

struct WeatherMain: Codable {
    let temp: Double
    let humidity: Double
}

struct WeatherWind: Codable {
    let speed: Double
}

struct WeatherDetail: Codable {
    let icon: String
}

```

- request와 response 두개가 필요하다.
- 간단히 구조만 만들어보기 위해서 request 모델에 기본값을 넣었다.

---
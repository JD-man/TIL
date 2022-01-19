# MVVM + Clean Architecture
- [Reference1](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)
- [Reference2](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)
- [Reference3](https://jeonyeohun.tistory.com/305)

## 목차
1. Layers
2. Data Flow
3. Example
---

## 1. Layers
#### 1) Domain layer
- Entities(Business Models), UseCase, Repository Interfaces(protocols). (EURI)
- Totally isolated, No dependencies or 3rd party are needed.
- Domain layer should not include anything from other layers.
- **UseCases include Business Logic** (Not ViewModel)

#### 2) Presentation layer
- Views, ViewModels(Presenters)
- ViewModels execute one or many UseCases.
- Depends only on Domain Layer.

#### 3) Data Layer
- Repository, Data Sources(DB), Network JSON Data
- **Repository request Data from Network or DB**
- Depends only on Domain Layer.

#### 4) Dependency Inversion
- Dependency Inversion : When Domain layer's UseCase request Data Layer's Repository to get reponse of DB
- But Repository conform Domain Layer's Repository Interface
- So still Data Layer depends on Domain Layer.

---

## 2. Data Flow
1. View calls method from ViewModel
2. ViewModel executes UseCase
3. UseCase combines data from User and Repositories
4. Repository returns data from Network or DB
5. Back to the View

- ViewModel(Presentation) call UseCase(Domain)
- UseCase(Domain) call Repository(Data) // Dependency Inversion
- Repository(Data) makes a requests to DB

---

## 3. Example

```swift
// viewModel

var someUseCase: UseCase = someUseCase()

struct Input {
    let someEvent: Obervable<Void>
}

struct Output {
    let someOutput: BehaviorRelay<String>(value: "JD")
}

func inputToUseCase(_ input: Input, disposeBag: DisposeBag) {

    input.someEvent
    .subscribe(onNext: { [weak self] in
        self?.someUseCase.makeData()
    }).disposed(by: disposeBag)
}

func makeOutput(disposeBag: DisposeBag) -> Output {
    var output: Output

    someUseCase.data    
    .bind(to: output.someOutput)
    .disposed(by: disposeBag)

    return output
}

// ViewController

func binding(_ output: someViewModel.output) {
    output.someOutput
    .asDriver(onErrorJustReturn: "")
    .drive( [weak self] in
        //...
    ).disposed(by: disposeBag)
}

```
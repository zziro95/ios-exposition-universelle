# 만국박람회 프로젝트
- 프로젝트 기간: 2020.12.21 ~ 2020.12.27    
- 팀 프로젝트 : [찌로](https://github.com/zziro95) / [그린](https://github.com/GREENOVER) man_technologist::man_technologist:    
- [팀 그라운드 룰]()
---
## 구현된 기능
- JSON 형태의 데이터와 매칭할 모델 타입 구현
- JSON 샘플 데이터를 이용한 테스트
- 스토리보드를 이용한 화면 구현   


움짤


---
그냥 코딩적인 부분은 트러블 슈팅으로 ㄱ
## 트러블 슈팅
### 1. 디코딩 시 발생하는 여러 오류
- 문제 상황
    - JSON 샘플 데이터를 디코딩 시 여러 상황의 오류를 접하였는데 어떤 오류인지 파악하는데 오랜 시간이 걸렸고, 그로인해 그 오류를 해결하는데 까지의 시간이 오래 걸리게 되어 개발 효율이 떨어졌습니다.   
- 고민 과정
    - 문법적인 오류일때도 있었고, 주어지는 데이터의 타입과 매칭되지 않는다는 오류도 있었습니다.
    - 디코딩 시 발생할 수 있는 오류는 어떤것들이 있으며 그것들을 구분하여 정확하게 파악하기 위해서는 어떤 작업을 해주어야 할까에 대해 고민해보았습니다.   
- 해결 방안   
    - [DecodingError](https://developer.apple.com/documentation/swift/decodingerror)에 대해 살펴봐 디코딩 시 어떤 오류가 발생하는지에 대해 공부했고, `do-catch` 문을 이용해 각 경우에 따라 어떤 오류인지와 세부 정보를 출력해주도록 아래와 같이 코드를 작성하였습니다.
    - 찾아보니 해당 방법이외에 `LocalizedError`를 사용하는 방법도 있다는 것을 알게되었습니다. 
    - 사용시 코드의 가독성이 더 좋아지고 경우에 맞는 오류 메세지를 출력해줄 수도 있습니다.
    - `LocalizedError`에 대해 알아보고 앞으로의 프로젝트에 적용해 볼 생각입니다.    
```swift
    do {
    self.expositionData = try jsonDecoder.decode(Exposition.self, from: dataAsset.data)
    } catch DecodingError.dataCorrupted(let context) {
    print("데이터가 손상되었거나 유효하지 않습니다.")
    print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
    } catch DecodingError.keyNotFound(let codingkey, let context) {
    print("주어진 키를 찾을수 없습니다.")
    print(codingkey.intValue ?? Optional(nil)! , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
    } catch DecodingError.typeMismatch(let type, let context) {
    print("주어진 타입과 일치하지 않습니다.")
    print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
    } catch DecodingError.valueNotFound(let type, let context) {
    print("예상하지 않은 null 값이 발견되었습니다.")
    print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
    } catch {
    print("그외 에러가 발생했습니다.")
    }
```   
<br>

### 2. Table View`s Content Type (Dynamic Prototypes or Static Cells) 
- 문제 상황
    - 기능요구서에 따르면 세 화면 모두 테이블뷰 이용하여 UI를 보여줘야했다.
    - 그러나 각 화면마다 표시해야 할 형식, 셀 수가 달랐고 다이나믹 타입을 사용할 경우 각 셀의 높이가 다른 경우에 대처할 수 없었다.   
- 고민 과정
    - [Table View Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/CreateConfigureTableView/CreateConfigureTableView.html)를 포함하여 관련 애플 공식 문서를 살펴보아 각 타입이 어떤 경우에 사용되는지에 대해 알아보았습니다.   
    - `Dynamic Prototypes` (동적 프로토 타입) 
        - 여러 셀이 동일한 레이아웃을 사용하여 정보를 표시해야 하는 경우 사용합니다.   
    - `Static Cells` (정적 셀 타입)
        - 보여줘야 하는 셀의 수와 구조가 정해져 있을 경우 사용합니다.
        - 표의 레이아웃이 변경되지 않을 경우에 사용합니다.   
- 해결 방안
    - 첫번째 화면과, 세번째 화면의 경우 보여줘야 하는 셀의 수와 구조가 정해져 있기 때문에 `Static Cells` 타입을 선택했고, 두번째 화면 같은 경우 여러 셀이 동일한 레이아웃을 사용하기 때문에 `Dynamic Prototypes` 타입을 선택하였습니다.   
ㅇㄹㅇㅇㄹㅇ 이미지 첫번째화면, 세번째화면 - 두번째 화면

<br>

### 3. 뭐 객체자체를 넘기는거? 스탭2리뷰 참고하기
- 문제 상황
    - JS
- 고민 과정
    - 문민해보았습니다.   
- 해결 방안   
    - d
    
---
## 고민한 점

    
### 프로퍼티의 네이밍과 타입, 옵셔널 처리
- 문제 상황
    - 처음에 `Exposition` 타입을 정의할 때 `titleImage`라는 프로퍼티명과 `String` 타입을 선택하였습니다.   
    - PR 요청후 리뷰 과정에서 아래와 같은 리뷰를 받게 되었습니다.    
// 푸시후 수정
<img src="https://github.com/zziro95/zzipository/blob/main/images/lsl.png" width="70%" height="70%" title="lsl" alt="lslImg"></img> <br>

- 고민 과정
    - JSON 샘플 데이터에 매칭하는 것에 대해서만 신경쓰고 이 프로퍼티가 어디로 호출 될 것이고, 어떻게 사용될지에 대한 고민이 부족했다고 생각이 들었습니다.   
- 결론
    - JSON 샘플을 통해 받아올 데이터에 대한 프로퍼티 네이밍을 `titleImage` -> `titleImageName`으로 변경해주고, 이 프로퍼티를 이용하여 `UIImage`를 리턴해주는 `titleImage` 읽기 전용 연산 프로퍼티를 생성해주었습니다.
    - 이미지 에셋에 존재하지 않는 이미지 이름(`titleImageName`) 전달시 런타임 오류가 발생할 수 있으므로 `UIImage?` 옵셔널 타입으로 채택 하였습니다. 
    - 또한 `titleImageName`은 JSON 데이터를 받고 `titleImage`의 값을 만들기 위해서만 사용되기 때문에 외부에 알려질 필요가 없다고 생각해 `private` 접근 제한자를 사용해 주었습니다.   
```swift
// 해당 부분 코드
struct Exposition: Codable {
    let title: String
    private let titleImageName: String
    ...

    var titleImage: UIImage? {
        return UIImage(named: self.titleImageName)
    }
    ...
}
```   
<br>

### 모델 뷰 컨트롤러의 역할과 책임 
- 문제 상황
    - 뷰 컨트롤러에 올려진 `UIImageView`, `UILabel`에 디코딩을 통해 얻은 데이터를 할당해 주어야 하는데 문자열 같은 경우 보여지기 전에 원하는 형태로 가공해주어야 했습니다. 
    - 데이터를 가공하는 작업을 모델에서 처리해주어야 할지 뷰 컨트롤러에서 처리해주어야 할지에 대한 고민을 하게 되었습니다.   
- 고민 과정
    - 작업을 어느 곳에서 다뤄야할지에 대한 기준이 명확하게 필요해야 한다고 생각이 들었습니다.
    - 타입의 저장 프로퍼티의 값을 이용해서 연산 프로퍼티나 메서드로 원하는 형식의 데이터로 가공할 수 도 있고, 저장 프로퍼티 값을 외부에서 호출해 그 값을 가지고 외부에서 가공 할 수도 있습니다.   
    - 타입의 내부에 정의해줄 경우 `장단점`에 대해서 생각해보았습니다.   
    - 타입의 내부에서 정의해준다는것은 그 타입이 쓰일 때 마다 필요할만큼 중요한 데이터임을 의미합니다.   
    - `장점`: 타입의 내부에 정의해줄 경우 다른 여러 객체에서 가공한 데이터가 필요할 때 가져다 사용하기만 하면 되기 때문에 코드의 중복이 줄어듭니다.   
    - `단점`: 모델의 역할이 너무 광범위해 질수 있고, 무거워 질 수 있다.
- 결론
    - 규모가 큰 프로젝트가 아니였고, 데이터와 문자열을 합치는 것과 같은 간단한 작업은 모델에서 읽기 전용 연산 프로퍼티를 사용하여 값을 가져갈 수 있게 구현하였고,
    - 타입 내부에 새로운 인스턴스를 생성해야 하거나 복잡한 작업을 모델에서 진행할시 모델이 무거워진다고 느껴 뷰컨트롤러에서 작업해 주었습니다.      


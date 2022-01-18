# Localization

## 다국어지원을 위한 설정
1. Project -> Info -> Localizations -> 원하는 국가 추가
2. Strings 파일 추가 -> 인스펙터창 Localization으로 원하는 국가 추가
3. Key-Value 같이 작성 (; 꼭 작성)
```swift
    // ContentLocalization.strings (English)
    "navigation_title" = "Keep a Journal";
    "titleTextField_placeholder" = "Please Write a title";
    "contentTextView_placeholder" = "Please write the content";
    "saveButton_title" = "Save";

    // ContentLocalization.strings (Korean)
    "navigation_title" = "일기 작성";
    "titleTextField_placeholder" = "제목을 작성해주세요.";
    "contentTextView_placeholder" = "내용을 작성해주세요.";
    "saveButton_title" = "저장";

```
4. 같이 사용할 Enum 작성. NSLocalizedString 이용
```swift
    enum ContentLocalizableString: String {
        case navigation_title
        case titleTextField_placeholder
        case contentTextView_placeholder
        case saveButton_title
        
        var localized: String {
            // tableName에 사용할 strings 파일 이름 적기
            return NSLocalizedString(self.rawValue,
                                    tableName: "ContentLocalization",
                                    bundle: .main,
                                    value: "",
                                    comment: "")
        }
    }
```

5. 뷰에 적용
```swift
    func viewConfig() {
        title = ContentLocalizableString.navigation_title.localized
    }
```
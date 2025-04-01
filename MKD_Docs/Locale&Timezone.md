#  Locale & Timezone

兩個都是包含地理位置的相關的 struct

# Locale

包含了一個地區的多種內容，例如語言、數字格式、貨幣格式、日期格式，不影響時間的計算，指引想顯示的格式

取用到 Locale 需要使用到 identifier ，例如 "zh-CN”、"ja_JP_POSIX”

```swift
let zhCN = Locale(identifier: "zh-CN")
```

也可以採用目前的 locale 來獲取特定的資訊

```swift
let currentTimeZone = TimeZone.current
print("\(currentTimeZone.identifier)") //Asia/Taipei
```

可以使用 Locale 來獲取不同國家的貨幣資訊，例如代碼或是符號

```swift
print(locale.currencyCode ?? "Unknown")  // "TWD"
print(locale.currencySymbol ?? "Unknown") // "NT$"
```

如果要格式化貨幣可以使用 `NumberFormatter`

```swift
let formatter = NumberFormatter()

formatter.numberStyle = .currency
formatter.locale = Locale(identifier: "jp-JP")
let mockPrice = 10002334455

print(formatter.string(from: NSNumber(value: mockPrice)) ?? "") // ¥ 10002334455
```

日期格式化可以使用 `DateFormetter`

 

```swift
let dateFormatter = DateFormatter()

dateFormatter.locale = Locale(identifier: "fr_FR")

dateFormatter.dateStyle = .full

let date = Date()

print(dateFormatter.string(from: date)) //vendredi 28 mars 2025
```

使用數字千分位格式

```swift
let formatter = NumberFormatter()

formatter.numberStyle = .decimal
formatter.locale = Locale(identifier: "de-DE")
let mockPrice = 10002334455

print(formatter.string(from: NSNumber(value: mockPrice)) ?? "") // 10.002.334.455
```

# Timezone

用於處理時區資訊，例如系統時區、轉換不同時區、計算時差。

獲得當前時區

```swift
let currentTimeZone = TimeZone.current
print(currentTimeZone) //Asia/Taipei
print(currentTimeZone.abbreviation() ?? "") //GMT+8
```

 

如果要顯示不同的時區，可以搭配 DateFormatter 

```swift
dateFormatter.timeZone = TimeZone.current

let date = Date()

print(dateFormatter.string(from: date)) //Friday, March 28, 2025 at 9:50:52 AM Taipei Standard Time
```

計算時間時差

```swift
let taipeiTimeZone = TimeZone(identifier: "Asia/Taipei") ?? TimeZone.current
let newYorkTimeZone = TimeZone(identifier: "America/New_York") ?? TimeZone.current

let difference = taipeiTimeZone.secondsFromGMT() - newYorkTimeZone.secondsFromGMT()

print(difference) //43200
```


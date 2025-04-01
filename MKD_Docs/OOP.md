# OOP 原則、特性 ＆ POP 

「OOP」又稱為物件導向程式設計，是一種具有「物件」概念的程式設計規範。

## 物件的定義

如果沒有物件的話，所有的程式都會散落在檔案的各處，如果沒有妥善進行管理將會造成維護上的困難以及降低程式的可讀性。

舉例來說，如果我們的專案內需要多個矩形的屬性，每個屬性會包含長、寬、面積等內容，在沒有經過物件管理的情況下，可能會有 `rect1Width` `rect2Height` `rect3Area` 這些不同的屬性，很容易造成使用上的不方便。如果透過一個物件進行管理，可以歸納出一個矩形的抽象定義，先將 height, width 等屬性進行包裝，再去針對物件進行實例化的使用。

在 Swift 中，可以透過 class 來進行 OOP 的實踐。

```swift
class Rect {

    let height: Double
    
    let width: Double
    
    var area: Double {
        return width * height
    }
    
    init (height: Double, width: Double) {
        self.height = height
        self.width = width
    }

}

let rect1 = Rect()
```

OOP 有三大特性：封裝、繼承、多型

# 封裝

物件的封裝性可以隱藏物件中的某些具體實現，在 swift 中也可以透過 Access Control 來指定特定類別的物件才能存取到這個特定的內容。

舉例來說，在一個 post API 的函式裡，總共會用到以下三個函式：

```swift
func sendRequest(result: @escaping (Result<Data, Error>) -> Void) {

    let request = buildRequest()
    
    fetchData(from: request)

}

func buildRequest () -> URLRequest {

///...

}

func fetchData(from request: URLRequest) {

///...

}

```

我們主要會使用 `sendRequest` 發送我們的 post 請求，但 `sendRequest` 函式主體裡面會先呼叫 `buidRequest` 建立 `URLRequest` ，接著在呼叫 `fetchData` 來發送剛剛建立的 `URLRequest`，並且透過閉包方式傳遞回 `sendRequest` 的閉包。

在以上例子，其實我們只會在發送 post 請求時調用到 `sendRequest` 所以 `buidRequest` 和 `URLRequest` 是不會單獨被調用的，這個時候就可以對這兩者進行封裝的處理：

```swift
class API {

    func sendRequest(result: @escaping (Result<Data, Error>) -> Void) {
    
        let request = buildRequest()
        
        fetchData(from: request)
    
    }
    
    private func buildRequest () -> URLRequest {
    
        ///...
    
    }
    
    private func fetchData(from request: URLRequest) {
    
        ///...
    
    }

}
```

這樣從外部存取到 `API` 的物件就不會有機會使用到 `buidRequest` 和 `URLRequest`

也可以對 class `API` 進行封裝：

```swift
class PostAPI {

    let api = API()
    
    func doSomething {
        api.sendrequest()
    }

}
```

# 繼承

在 Swift 中，可以對 class 進行繼承，讓子類別可以完整得到父類別的函式和屬性。除此之外，子類別也可以再額外添加屬性或函式，也可以覆寫父類別的內容。

```swift
class Dog {

    func bark() {
        print("Woof")
    }
    
}

class wolf: Dog {
    
    override func bark() {
        print("Howl")
    }
    
    func bite() {
        print("bite something")
    }

}

class Chihuahua: Dog {
    
    override func bark() {
        print("Bark")
    }
    
    func scream() {
        print("screaming")
    }
    
}
```

在上述範例中，class `Wolf` `Chihuahua` 因為繼承自dog，所以都可以使用到父類別的函式 `bark()` 並進行覆寫 。此外也因為另外在 class 中加上其他內容，所以 `Chihuahua` 無法使用到 `bite()`，`Wolf` 也沒辦法使用到 `scream()`。

在 Swift 中只能夠繼承自一個 class。

# 多型

多型是指由繼承所產生的多個不同的類別，可能會對同一個訊息產生不同的反應，例如上一個例子，`Dog` `Wolf` `Chihuahua` 都有 `bark()`，但是執行出的行爲各異

```swift
let dog = Dog()
let wolf = Wolf()
let chihuahua = Chihuahua()

let dogs: [Dog] = [dog, wolf, chihuahua]

for dog in dogs {
    dog.bark()
}
// Woof
// Howl
// Bark
```

也因為 `Wolf` `Chihuahua` 都是 Dog 的子類別，才可以把他們歸類到 `[Dog]` 型別的數列裡，而這時候已沒辦法呼叫 `scream()` 或是 `bite()` 因為此時只把他們當作 Dog 型別來看待。

可以用 is 來檢查一個屬性是否是特定的型別，也可以用 as 來**向下**轉換成子類別。

```swift
for dog in dogs {
    
    if dog is Wolf {
        print("Wolf")
    } else if dog is Chihuahua {
        print("Chihuahua")
    } else {
        print("Dog")
    }
    
}
```

```swift
for dog in dogs {

    if let wolf = dog as Wolf? {
        wolf.bite()
    } else if let chihuahua = dog as? Chihuahua {
        chihuahua.scream()
    } else {
        dog.bite()
    }

}

```

# SOLID

### **Single Responsibility Principle / SRP 單一職責原則**

- 一個 function 應該只會有一個職責（只應該有一個變化的原因）
- 為避免物件過於肥大，並盡量減少耦合，便於測試及維護

**範例**：

不好的範例：

```swift
class UserManager {
    func saveUser() { /* Save user to database */ }
    func sendEmail() { /* Send email to user */ }
}
```

`UserManager` 同時負責「存取資料庫」和「發送電子郵件」，違反單一職責原則。

改進：

```swift
class UserRepository {
    func saveUser() { /* Save user to database */ }
}

class EmailService {
    func sendEmail() { /* Send email to user */ }
}

```

現在每個 class 只有單一的責任。

### **開放封閉原則**

- 對拓展開放，對修改封閉
- 允許新增功能而不影響原有程式碼
- 通過抽象（如接口）來提高靈活性

壞範例：

```swift
class Shape {
    func drawCircle() { /* Draw a circle */ }
    func drawSquare() { /* Draw a square */ }
}
```

如果新增了三角形，則需要修改 Shape，可以透過抽象的方式讓函式獨立出來並分割職權

```swift
protocol Shape {
    func draw()
}

class Circle: Shape {
    func draw() { /* Draw a circle */ }
}

class Square: Shape {
    func draw() { /* Draw a square */ }
}
```

### 李氏替換原則

- 子類必須可以替換父類，並且不會影響程式行為
- 子類必須完全實現父類的行為，不能弱化約束條件
- 確保繼承的正確性，避免違反多態

壞範例：

```swift
class Bird {
    func fly() { print("Flying") }
}

class Penguin: Bird {
    override func fly() {
    }
}

```

企鵝執行 `fly()` 不合理，違反李氏替換原則

改進範例：

```swift
protocol bird {
    func move() 
}

class FlyingBird: Bird {
    func move() { print("flying")}
}

class Penguin: Bird {
    func move() {print("swimming")}
}
```

`penguin` 和 `flyingBird` 都遵守了 Bird 的行為，但實際使用的方式不同

### 介面隔離原則

- **接口應該小而專一，避免大而全的接口**
- 客戶端不應依賴不需要的接口功能

壞範例：

```swift
protocol Worker {
    func work()
    func eat()
}

class Robot: Worker {
    func work() { print("Working") }
    func eat() { // robots dont eat}
}

```

如果統一接口，會出現 Robot 能夠執行它不能執行的行為，違反介面隔離原則

```swift
protocol Workable {
    func work()
}

protocol Eatable {
    func eat()
}

class Human: Workable, Eatable {
    func work() { print("Working") }
    func eat() { print("Eating") }
}

class Robot: Workable {
    func work() { print("Working") }
}

```

robot 只實現 workable

### 依賴反轉原則

- **高層模組不應依賴低層模組，兩者都應依賴於抽象**。
- **抽象不應依賴具體實現，具體實現應依賴抽象**。
- 提高系統的靈活性與可測試性。

壞範例：

```swift
swift
複製程式碼
class Keyboard {
    func type() { print("Typing") }
}

class Computer {
    let keyboard = Keyboard()
}

```

`Computer` 直接依賴具體的 `Keyboard` 類別

```swift
protocol InputDevice {
    func input()
}

class Keyboard: InputDevice {
    func input() { print("Typing") }
}

class Computer {
    var inputDevice: InputDevice
    init(inputDevice: InputDevice) {
        self.inputDevice = inputDevice
    }
}

```

# OOP

OOP 的好處就是可以繼承自其他類別，從而延伸到封裝、抽象、多態等等的實作，但在 Swift 中，類別無法多重繼承，代表只能繼承自一個類別，如果要同時繼承多個類別將會報錯。

POP 也同樣共享了很多OOP的好處，但其中最大的差異是，類別可以繼承自多個 protocol 。

很多時候在專案變大時，通常會不段添加新內容到繼承結構最頂部的類別，這樣一來很容易就導致類別的肥大，讓 Mid-level 和 leaf-level 的類別繼承到不必要的功能。而 POP 的概念下因為一個類別可以同時尊崇多個 protocol 而就可以把職權劃分得更細緻。

另外繼承的概念只發生在類別之中，但在 Swift 中也有許多 value type 的物件會被使用到，例如 enum, struct，而 protocol 就可以同時套用在 class 、 struct、enum 之中。

```swift
protocol SimpleViewWithBuilder {
    
}

extension SimpleViewWithBuilder where Self: UIView{
    
    @MainActor func addBorder() -> Void {
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 10.0
    }
    
}

class SimpleUIViewWithBuilder: UIView, SimpleViewWithBuilder {
    
}

@MainActor func addSubview(view: UIView) {
    
    let customFrame0 = CGRect(x: 100, y: 100,  width: 100, height: 100)
    
    let customView0 = SimpleUIViewWithBuilder(frame: customFrame0)
    
    customView0.addBorder()
    
    view.addSubview(customView0)
    
}
```


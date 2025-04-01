/// <#Brief Description#> 
///
/// Created by TWINB00776283 on 2025/3/21.
/// Copyright © 2025 Cathay United Bank. All rights reserved.

public class PublicClass {
    public let openClass = OpenClass()
    public func openClassComputedProperty() -> Int {
        openClass.computedProperty
    }
}

// override method 的層級需要與 parent class method 的層級相同。//

class PublicSubclass: PublicClass {
    override internal func openClassComputedProperty() -> Int {
        openClass.computedProperty + 1
    }
}
// 在 framework 中，access control 為 internal 的情況下，只要是在 framework 內部的程式碼都可以存取，但是如果是 import 到外部的專案則無法透過外部進行存取。如果是 private 的話代表完全的封裝，不管是 framework 內部還是外部都沒辦法存取。而 fileprivate 則是只限定在 framework 內同一資料的話才可以存取。


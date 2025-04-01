/// <#Brief Description#> 
///
/// Created by TWINB00776283 on 2025/3/25.
/// Copyright © 2025 Cathay United Bank. All rights reserved.

fileprivate class fileprivatelClass {
    
    fileprivate var int: Int = 100
    
    fileprivate var computedProperty: Int {
        get {int * 20}
        set {int -= newValue}
    }
}

public class WrappedFileprivateClass {
    
    fileprivate let fileprivateClass = fileprivatelClass()
    
    public func getComputedProperty(int: Int) -> Int {
       return fileprivateClass.computedProperty
    }
    
}

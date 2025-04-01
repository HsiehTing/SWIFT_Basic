/// <#Brief Description#> 
///
/// Created by TWINB00776283 on 2025/3/21.
/// Copyright © 2025 Cathay United Bank. All rights reserved.

import Foundation

open class OpenClass {
    
    open var int: Int = 100
    
    open var computedProperty: Int {
        get {int * 20}
        set {int -= newValue}
    }
}

// MARK: 不能只 override get{}，因為會把 computed property 轉變成 read-only。//

public class OpenSubclass: OpenClass {
    public override var computedProperty: Int {
        get {int * -20}
        set {int -= newValue}
    }
}




//
//  DateFormatterView.swift
//  SWIFTBasics
//
//  Created by TWINB00776283B on 2025/3/31.
//

class DateFormatterView: ViewController {
    
    let model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let adString = model.adGetString()
        let adDate = model.adStringToDate(string: adString)
        
        let rocString = model.rocGetString()
        let rocDate = model.rocStringToDate(string: rocString)
        print(adString)
        print(adDate)
        print(rocString)
        print(rocDate)
    }
    
}

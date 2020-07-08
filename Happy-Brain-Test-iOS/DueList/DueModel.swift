//
//  DueModel.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 08.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//

import UIKit

struct Due {
    var title: String
    var time: Date
    var smile: Smile
}

extension Due {
    static var good: Due {
        Due(title: "Некая запись", time: Date(), smile: .good)
    }
    
    static var bad: Due {
        if #available(iOS 13.0, *) {
            return Due(title: "Некая запись", time: Date().advanced(by: -1*3600*24), smile: .bad)
        } else {
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
            return Due(title: "Некая запись", time: date, smile: .bad)
        }
    }
    
    static var middle: Due {
        if #available(iOS 13.0, *) {
            return Due(title: "Некая запись", time: Date().advanced(by: -2*3600*24), smile: .middle)
        } else {
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .day, value: -2, to: Date()) ?? Date()
            return Due(title: "Некая запись", time: date, smile: .middle)
        }
    }
}


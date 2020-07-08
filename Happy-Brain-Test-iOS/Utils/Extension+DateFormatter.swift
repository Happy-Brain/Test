//
//  Extension+DateFormatter.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 09.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var time: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df
    }
    
    static var shortDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .full
        return df
    }
}

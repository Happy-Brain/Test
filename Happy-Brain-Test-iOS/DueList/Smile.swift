//
//  Smile.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 09.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//
import UIKit.UIColor

enum Smile: CaseIterable {
    case good, bad, middle
    
    var title: String {
        switch self {
        case .good:
            return "😀"
        case .bad:
            return "😭"
        case .middle:
            return "😒"
        }
    }
    
    var description: String {
        switch self {
        case .good:
            return "Хорошо"
        case .bad:
            return "Плохо"
        case .middle:
            return "Срдне"
        }
    }
    
    var color: UIColor {
        switch self {
        case .good:
            return UIColor.green
        case .bad:
            return UIColor.red
        case .middle:
            return UIColor.yellow
        }
    }
}

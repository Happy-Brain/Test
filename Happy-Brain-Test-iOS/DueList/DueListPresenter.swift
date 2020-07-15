//
//  DueListPresenter.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 08.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//

import UIKit

protocol DueListPresenterIn: class {
    func viewDidLoad(with controller: DueListViewController)
    func dueItems() -> [DataSource]
    func dueAdded(due: Due)
}

protocol DueListPresenterOut: class {
    func duesRecieved()
}

class DueListPresenter: DueListPresenterIn {
    
    weak var delegate: DueListPresenterOut?
    
    var dues: [Due] = [.good, .bad, .middle]
    
    func viewDidLoad(with controller: DueListViewController) {
        self.delegate = controller
        self.delegate?.duesRecieved()
    }
    
    func dueItems() -> [DataSource] {
        return self.dues
            .reduce(into: [String:[Due]]()) { (result, due) in
                result[DateFormatter.shortDate.string(from: due.time), default: []].append(due)}
            .reduce(into: [DataSource]()) { (result, dict) in
                result.append(DataSource(title: dict.key, items: dict.value.sorted(by: { (left, right) -> Bool in
                    left.time < right.time
                })))}
            .sorted { (left, right) -> Bool in
                DateFormatter.shortDate.date(from: left.title) ?? Date() > DateFormatter.shortDate.date(from: right.title) ?? Date()
        }
    }
    
    func dueAdded(due: Due) {
        self.dues.append(due)
        self.delegate?.duesRecieved()
    }
}

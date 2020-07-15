//
//  AddDueViewController.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 09.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//

import UIKit

protocol AddDueViewControllerDelegate: class {
    func dueAdded(due: Due)
}

class AddDueViewController: UIViewController {

    @IBOutlet weak var smileSegmetController: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    
    let segments: [Smile] = Smile.allCases
    weak var delegate: AddDueViewControllerDelegate?
    var addCase: AddCase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smileSegmetController.removeAllSegments()
        var index = 0
        for segment in segments {
            smileSegmetController.insertSegment(withTitle: segment.title, at: index, animated: true)
            index += 1
        }
        smileSegmetController.selectedSegmentIndex = 0
    }
    
    private func save() {
        let selectedSegment = segments[smileSegmetController.selectedSegmentIndex]
        
        guard let title = titleTextField.text, title != "" else {
            self.presentAlert(with: "Заполните описание")
            return
        }
        switch addCase {
        case .next(let current, let next):
            switch next {
            case .some(let next):
                let timeDiff = (next.time.timeIntervalSince1970 - current.time.timeIntervalSince1970) / 2
                if #available(iOS 13.0, *) {
                    let date = current.time.advanced(by: timeDiff)
                    let due = Due(title: title, time: date, smile: selectedSegment)
                    self.delegate?.dueAdded(due: due)
                } else {
                    // MARK: Исправить для версии ниже 13
                }
                
            case .none:
                if #available(iOS 13.0, *) {
                    let date = current.time.advanced(by: 15 * 60)
                    let due = Due(title: title, time: date, smile: selectedSegment)
                    self.delegate?.dueAdded(due: due)
                } else {
                    // MARK: Исправить для версии ниже 13
                }
            }
        case .previous(let previous, let current):
            switch previous {
            case .some(let previous):
                let timeDiff = (current.time.timeIntervalSince1970 - previous.time.timeIntervalSince1970) / 2
                if #available(iOS 13.0, *) {
                    let date = current.time.advanced(by: -timeDiff)
                    let due = Due(title: title, time: date, smile: selectedSegment)
                    self.delegate?.dueAdded(due: due)
                } else {
                    // MARK: Исправить для версии ниже 13
                }
                
            case .none:
                if #available(iOS 13.0, *) {
                    let date = current.time.advanced(by: -15 * 60)
                    let due = Due(title: title, time: date, smile: selectedSegment)
                    self.delegate?.dueAdded(due: due)
                } else {
                    // MARK: Исправить для версии ниже 13
                }
            }
        case .none:
            let due = Due(title: title, time: Date(), smile: selectedSegment)
            self.delegate?.dueAdded(due: due)
        }
        self.dismiss(animated: true, completion: nil)
    }

@IBAction func cancelButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
}

@IBAction func addButtonTapped(_ sender: Any) {
        save()
    }
}

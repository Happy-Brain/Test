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
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let selectedSegment = segments[smileSegmetController.selectedSegmentIndex]
        
        guard let title = titleTextField.text, title != "" else {
            self.presentAlert(with: "Заполните описание")
            return
        }
        
        let due = Due(title: title, time: Date(), smile: selectedSegment)
        self.delegate?.dueAdded(due: due)
        
        self.dismiss(animated: true, completion: nil)
    }
}

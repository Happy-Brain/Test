//
//  ViewController.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 08.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//

import UIKit

class DueListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let presenter: DueListPresenterIn = DueListPresenter()
    
    var dataSource: [DataSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Due List"
        tableView.dataSource = self
        tableView.delegate = self
        presenter.viewDidLoad(with: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            if let destinationViewController = navigationController.viewControllers.first as? AddDueViewController {
                destinationViewController.delegate = self
            }
        }
    }
    
    func loadData() {
        self.dataSource = presenter.dueItems()
        self.tableView.reloadData()
    }
}

extension DueListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DueTableViewCell
        let item = dataSource[indexPath.section].items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].title
    }
    
}

extension DueListViewController: DueListPresenterOut {
    func duesRecieved() {
        loadData()
    }
}

extension DueListViewController: AddDueViewControllerDelegate {
    func dueAdded(due: Due) {
        self.presenter.dueAdded(due: due)
    }
}

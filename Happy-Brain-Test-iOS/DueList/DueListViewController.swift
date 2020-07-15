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
    
    var addCase: AddCase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Due List"
        tableView.dataSource = self
        tableView.delegate = self
        presenter.viewDidLoad(with: self)
        
        // MARK: TODO: рассмотрет другой вариант анимации, поставить счетчик на количество повторов анимации при запуске приложения, чтобы отключить анимацию, когда пользователь уже научился ползоваться свайпами
        if dataSource.count != 0 {
            if dataSource[0].items.count != 0 {
                animateFirstRow(tableView: tableView, indexPath: IndexPath(row: 0, section: 0))
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            if let destinationViewController = navigationController.viewControllers.first as? AddDueViewController {
                destinationViewController.delegate = self
                destinationViewController.addCase = self.addCase
            }
        }
    }
    
    func loadData() {
        self.dataSource = presenter.dueItems()
        self.tableView.reloadData()
    }
    
    func animateFirstRow(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }

        UIView.animate(withDuration: 0.6, animations: {
            cell.frame = CGRect(x: cell.frame.origin.x + 10, y: cell.frame.origin.y, width: cell.bounds.size.width, height: cell.bounds.size.height)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, animations: {

                cell.frame = CGRect(x: cell.frame.origin.x - 10, y: cell.frame.origin.y, width: cell.bounds.size.width, height: cell.bounds.size.height)

            }, completion: { (finished) in
                UIView.animate(withDuration: 0.3) {
                    cell.frame = CGRect(x: cell.frame.origin.x + 10, y: cell.frame.origin.y, width: cell.bounds.size.width, height: cell.bounds.size.height)
                }
            })
        }
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
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let previousIndex = indexPath.row - 1
        let action = UIContextualAction(style: .normal, title: "Вставить до") { (action, view, completion) in
            if previousIndex >= 0 && previousIndex < self.dataSource[indexPath.section].items.count  {
                self.addCase = AddCase.previous(self.dataSource[indexPath.section].items[previousIndex], self.dataSource[indexPath.section].items[indexPath.row])
            } else {
                self.addCase = AddCase.previous(nil, self.dataSource[indexPath.section].items[indexPath.row])
            }
            self.performSegue(withIdentifier: "showAddDue", sender: self)
            completion(true)
        }
        action.backgroundColor = UIColor.cyan
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let nextIndex = indexPath.row + 1
        let action = UIContextualAction(style: .normal, title: "Вставить после") { (action, view, completion) in
            if self.dataSource[indexPath.section].items.count - 1 >= nextIndex {
                self.addCase = AddCase.next(self.dataSource[indexPath.section].items[indexPath.row], self.dataSource[indexPath.section].items[nextIndex])
            } else {
                self.addCase = AddCase.next(self.dataSource[indexPath.section].items[indexPath.row], nil)
            }
            self.performSegue(withIdentifier: "showAddDue", sender: self)
            completion(true)
        }
        action.backgroundColor = UIColor.magenta
        return UISwipeActionsConfiguration(actions: [action])
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
        self.addCase = nil
    }
}

enum AddCase {
    case previous(Previous?, Current)
    case next(Current, Next?)
}

typealias Previous = Due
typealias Next = Due
typealias Current = Due

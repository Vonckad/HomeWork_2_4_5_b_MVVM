//
//  ViewModel.swift
//  HomeWork_2_4_5_b_MVVM
//
//  Created by Vlad Ralovich on 2/20/21.
//

import Foundation
import UIKit
import RealmSwift

class ViewModel {
    
    private var realm: Realm!
    var todoList: Results<PersistanceRealm> {
        get { return realm.objects(PersistanceRealm.self)}
    }
    
    func configurateView() {
        realm = try! Realm()
    }
    
    func pressButton(tableView: UITableView) -> UIAlertController {
        
        let alert = UIAlertController(title: "Новая задача", message: "", preferredStyle: .alert)
        alert.addTextField { textField in }
        
        let todoItemTextField = (alert.textFields?.first)! as UITextField
        let canceAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (addAlertButton) -> Void in
           
            let todoListItem = PersistanceRealm()
                            
            if let text = todoItemTextField.text {
                if text.count > 0 {
                todoListItem.name = text
                    try! self.realm.write({
                        self.realm.add(todoListItem)

                        tableView.insertSections(IndexSet(integer: self.todoList.count - 1), with: .right)
                    })
                }
            }
        }
        
        alert.addAction(canceAction)
        alert.addAction(addAction)
        return alert
    }
    
    func selectRow(tableView: UITableView, indexPath: IndexPath) {
        try! realm.write({
            realm.delete(todoList[indexPath.section])
        })
        tableView.deleteSections(IndexSet(integer: indexPath.section), with: .left)
    }
}

//
//  ViewController.swift
//  HomeWork_2_4_5_b_MVVM
//
//  Created by Vlad Ralovich on 2/19/21.
//

import UIKit

class ViewController: UIViewController {

    var myTableView: UITableView!
    var label: UILabel!
    var addButton: UIButton!
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurate()
        myTableView.delegate = self
        myTableView.dataSource = self
        viewModel.configurateView()
    }
    
    func configurate() {
        view.backgroundColor = .systemGray4
        
        label = UILabel()
        label.text = "TO-DO"
        
        myTableView = UITableView()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.backgroundColor = .systemGray4
        myTableView.tableFooterView = UIView()
        myTableView.separatorStyle = .none
        myTableView.showsVerticalScrollIndicator = false
        
        addButton = UIButton()
        addButton.setTitle("   Write a new task          ", for: .normal)
        addButton.addTarget(nil, action: #selector(actionAddButton), for: .touchUpInside)
        addButton.backgroundColor = .systemBackground
        addButton.layer.cornerRadius = 15
        addButton.setTitleColor(.label, for: .normal)
        
        view.addSubview(label)
        view.addSubview(myTableView)
        view.addSubview(addButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: myTableView.topAnchor, constant: -8).isActive = true

        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16).isActive = true

        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
    }
    
    @objc func actionAddButton() {
        present(viewModel.pressButton(tableView: myTableView), animated: true, completion: nil)
    }
}

// MARK: - extension ViewController
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = .systemGray4
        return headView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(tableView: tableView, indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.todoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.todoList[indexPath.section].name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = .clear
        
        return cell
    }
}

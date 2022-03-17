//
//  BMILogVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/17/22.
//

import UIKit

class BMILogVC: UIViewController {
    
    // MARK: Properties
    
    let tableView = UITableView()
    let viewModel = BMILogVM()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    
    // MARK: UI
    func setupViews() {
        view.backgroundColor = .FPBackground
        title = "BMI History"
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.backgroundColor = .FPBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BMILogTableViewCell.self, forCellReuseIdentifier: CellId.bmiLogCell)
        tableView.separatorStyle = .none
    }
    
    
}

extension BMILogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.bmiLogCell) as! BMILogTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

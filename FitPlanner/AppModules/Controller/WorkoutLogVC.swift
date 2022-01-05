//
//  SecondViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class WorkoutLogVC: UIViewController {

    // MARK: Properties
    let yourWorkoutsLabel = FPLabel(title: "Your next workout", color: .primary, size: 20, weight: .medium)
    
    var workoutLogViewModel = WorkoutLogVM()
    
    var tableView = UITableView()
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubview(yourWorkoutsLabel)
        yourWorkoutsLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40, paddingLeft: 20)
        
        view.addSubview(tableView)
        tableView.anchor(top: yourWorkoutsLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkoutCardTableViewCell.self, forCellReuseIdentifier: CellId.workoutCell)
        
        print(workoutLogViewModel.yourWorkouts.count)
        
    }
}


// MARK: TableView Protocols
extension WorkoutLogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.workoutLogViewModel.yourWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModelToUse = self.workoutLogViewModel.yourWorkouts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.workoutCell) as! WorkoutCardTableViewCell
        cell.selectionStyle = .none
        cell.setViewModel(as: viewModelToUse)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected workout")
        print(workoutLogViewModel.yourWorkouts[indexPath.row])
    }
    
    
}

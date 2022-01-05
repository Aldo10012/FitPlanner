//
//  SecondViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit

class WorkoutLogVC: UIViewController {

    // MARK: Properties
    let yourWorkoutsLabel = FPLabel(title: "Your workouts", color: .primary, size: 20, weight: .medium)
    
    var workoutLogViewModel = WorkoutLogVM()
    var tableView = UITableView()
    
    let createNewWorkoutButton = FPButton(type: .primary, title: "Create new workout", target: self, action: #selector(didTapCreateWorkoutButton))
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    
    // MARK: Selectors
    @objc func didTapCreateWorkoutButton() {
        Router.pushToWorkoutPlan(from: self, type: .addWorkout, viewModel:
            WorkoutCardVM(title: "", onSun: false, onMon: false, onTue: false, onWed: false, onThu: false, onFri: false, onSat: false)
        )
    }
    
    // MARK: UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        
        view.addSubview(yourWorkoutsLabel)
        yourWorkoutsLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 40, paddingLeft: 20)
        
        view.addSubview(createNewWorkoutButton)
        createNewWorkoutButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        view.addSubview(tableView)
        tableView.anchor(top: yourWorkoutsLabel.bottomAnchor, left: view.leftAnchor, bottom: createNewWorkoutButton.topAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
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
        
        let viewModelToUse = workoutLogViewModel.yourWorkouts[indexPath.row]
        Router.pushToWorkoutPlan(from: self, type: .editWorkout, viewModel: viewModelToUse)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = workoutLogViewModel.yourWorkouts[indexPath.row]
            self.workoutLogViewModel.yourWorkouts.remove(at: indexPath.row)
//            myData.deleteTodoItem(object)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
}

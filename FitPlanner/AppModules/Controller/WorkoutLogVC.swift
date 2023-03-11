//
//  SecondViewController.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/4/22.
//

import UIKit
import CoreData

class WorkoutLogVC: UIViewController {

    // MARK: Properties
    let workoutStorage = WorkoutCoreDataStorage()
    let yourWorkoutsLabel = FPLabel(title: "Your workouts", color: .primary, size: 20, weight: .medium)
    
    var viewModel = WorkoutLogVM()
    var tableView = UITableView()
    
    let createNewWorkoutButton = FPButton(type: .primary, title: "Create new workout", target: self, action: #selector(didTapCreateWorkoutButton))
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        viewModel.onViewDidLoad {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        tableView.anchor(top: yourWorkoutsLabel.bottomAnchor, left: view.leftAnchor, bottom: createNewWorkoutButton.topAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 10, paddingBottom: 20, paddingRight: 10)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkoutCardTableViewCell.self, forCellReuseIdentifier: CellId.workoutCell)
        
        print(viewModel.yourWorkouts.count)
        
    }
}


// MARK: TableView Protocols
extension WorkoutLogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.yourWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModelToUse = self.viewModel.yourWorkouts[indexPath.row]
        
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
        print(viewModel.yourWorkouts[indexPath.row])
        
        let viewModelToUse = viewModel.yourWorkouts[indexPath.row]
        Router.pushToWorkoutPlan(from: self, type: .editWorkout, viewModel: viewModelToUse)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = viewModel.yourWorkouts[indexPath.row]
            self.viewModel.yourWorkouts.remove(at: indexPath.row)
            workoutStorage.deleteWorkout(object.workout)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
}


// MARK: WorkoutChangedDelegate
extension WorkoutLogVC: WorkoutChangedDelegate {
    func updateWorkoutList() {
        print("User did make a change")
        viewModel.onWorkoutsWereChanged {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    
}

//
//  WorkoutPlanVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit

enum WorkoutPlanType {
    case nextWorkout
    case addWorkout
    case editWorkout
}

class WorkoutPlanVC: UIViewController {

    // MARK: - Properties
    var type: WorkoutPlanType!
    
    var workoutNameTextField = FPTextField(placeholder: "Workout name", size: 30, weight: .light)
    var workoutcardView: WorkoutCardView!
    var button = FPButton(type: .primary, title: "Button")
    
    
    convenience init(type: WorkoutPlanType, viewModel: WorkoutCardVM) {
        self.init()
        self.type = type
        modifyViewBasedOnType(viewModel: viewModel)
    }
    
    
    // MARK: Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    

    // MARK: Selectors
    @objc func didTapMarkAsDone() {
        print("did Tap MarkAsDone")
        Router.dismissController(self)
    }
    
    @objc func didTapAdd() {
        print("did Tap Add")
        Router.dismissController(self)
    }
    
    @objc func didTapEdit() {
        print("did Tap Edit")
        Router.dismissController(self)
    }
    
    
    // MARK: - UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        title = "Workout Plan"
        
        view.addSubview(workoutNameTextField)
        workoutNameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 20)
        
        view.addSubview(workoutcardView)
        workoutcardView.anchor(top: workoutNameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                               paddingTop: 30, paddingLeft: 20, paddingRight: 30)
        
        view.addSubview(button)
        button.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
    }
    
    // MARK: Check type
    fileprivate func modifyViewBasedOnType(viewModel: WorkoutCardVM) {
        switch self.type {
        case .nextWorkout:
            print(viewModel)
            
            workoutcardView = WorkoutCardView(viewModel: viewModel)
            button.setTitle("Mark as done", for: .normal)
            button.addTarget(self, action: #selector(didTapMarkAsDone), for: .touchUpInside)
            workoutNameTextField.isEnabled = false
            break
        
        case .addWorkout:
            print(viewModel)

            workoutcardView = WorkoutCardView(viewModel: viewModel)
            button.setTitle("Add", for: .normal)
            button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
            workoutcardView.label.text = "Schedule"
            break
            
        case .editWorkout:
            print(viewModel)

            workoutcardView = WorkoutCardView(viewModel: viewModel)
            button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
            button.setTitle("Edit", for: .normal)
            workoutcardView.label.text = "Schedule"
            workoutNameTextField.text = viewModel.title
            break
            
        case .none:
            break
        }
    }
    

}

//
//  WorkoutPlanVC.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/5/22.
//

import UIKit
import CoreData

enum WorkoutPlanType {
    case nextWorkout
    case addWorkout
    case editWorkout
}

class WorkoutPlanVC: UIViewController {

    // MARK: - Properties    
    var type: WorkoutPlanType!
    var viewModel = WorkoutPlanVM()
    let myData = CoreDataStack()
    
    var workoutNameTextField = FPTextField(placeholder: "Workout name", size: 30, weight: .light)
    var workoutcardView: WorkoutCardView!
    var addExerciseCard = AddExerciseCardView()//FPBackground(radius: 8)
//    var tableView = UITableView()
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
        Router.popController(self)
    }
    
    @objc func didTapAdd() {
        print("did Tap Add")
        getViewStateAndPassToViewModel { [self] in
            viewModel.createWorkout()
            Router.popController(self)
        } fail: {
            AlertManager.showFillInExercises(on: self)
        }
    }
    
    @objc func didTapEdit() {
        print("did Tap Edit")
        getViewStateAndPassToViewModel { [self] in
            viewModel.editWorkout()
            Router.popController(self)
        } fail: {
            AlertManager.showFillInExercises(on: self)
        }
    }
    
    @objc func didTapAddExerciseButton() {
        let newExercise = Exercise(context: myData.managedContext)
        viewModel.exercises.append(newExercise)
        addExerciseCard.tableView.reloadData()
    }
    
    
    // MARK: - UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        title = "Workout Plan"
        
        view.addSubviews(workoutNameTextField, workoutcardView, button, addExerciseCard)
        
        workoutNameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 20)
        
        workoutcardView.anchor(top: workoutNameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                               paddingTop: 30, paddingLeft: 20, paddingRight: 30)
        
        button.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        addExerciseCard.addStandardShadow()
        addExerciseCard.anchor(top: workoutcardView.bottomAnchor, left: workoutcardView.leftAnchor, right: workoutcardView.rightAnchor, paddingTop: 30, height: 250)
        
        addExerciseCard.tableView.delegate = self
        addExerciseCard.tableView.dataSource = self
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
            addExerciseCard.hasAddButton()
            addExerciseCard.addExerciseButton.addTarget(self, action: #selector(didTapAddExerciseButton), for: .touchUpInside)
            makeDayOfWeekButtonsEditable()
            break
            
        case .editWorkout:
            print(viewModel)

            workoutcardView = WorkoutCardView(viewModel: viewModel)
            button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
            button.setTitle("Edit", for: .normal)
            workoutcardView.label.text = "Schedule"
            workoutNameTextField.text = viewModel.title
            addExerciseCard.hasAddButton()
            addExerciseCard.addExerciseButton.addTarget(self, action: #selector(didTapAddExerciseButton), for: .touchUpInside)
            makeDayOfWeekButtonsEditable()
            break
            
        case .none:
            break
        }
    }
    
    // MARK: Make buttons editable
    fileprivate func makeDayOfWeekButtonsEditable() {
        workoutcardView.SunButton.canEdit = true
        workoutcardView.MonButton.canEdit = true
        workoutcardView.TueButton.canEdit = true
        workoutcardView.WedButton.canEdit = true
        workoutcardView.ThuButton.canEdit = true
        workoutcardView.FriButton.canEdit = true
        workoutcardView.SatButton.canEdit = true
    }
    
    // MARK: Helpers
    fileprivate func getViewStateAndPassToViewModel(success: @escaping() -> (), fail: @escaping() -> () ) {
        viewModel.name = workoutNameTextField.text
        viewModel.onSun = workoutcardView.SunButton.workoutIsScheduled
        viewModel.onMon = workoutcardView.MonButton.workoutIsScheduled
        viewModel.onTue = workoutcardView.TueButton.workoutIsScheduled
        viewModel.onWed = workoutcardView.WedButton.workoutIsScheduled
        viewModel.onThu = workoutcardView.ThuButton.workoutIsScheduled
        viewModel.onFri = workoutcardView.FriButton.workoutIsScheduled
        viewModel.onSat = workoutcardView.SatButton.workoutIsScheduled
        
        // TODO: This only gets VISIBLE cells, not all cells. Edit to get ALL cells
        // TODO: TableView reshuffles the exercises when u add new one
        let cells = addExerciseCard.tableView.visibleCells as! Array<ExerciseTableViewCell>

        var onCell: Int = 0
        for cell in cells {
            if cell.nameTextField.text == "" || cell.setsTextField.text == "" || cell.repsTextField.text == "" {
                fail()
                return
            }
            
            viewModel.exercises[onCell].name = cell.nameTextField.text
            viewModel.exercises[onCell].reps = Int64(cell.repsTextField.text!)!
            viewModel.exercises[onCell].sets = Int64(cell.setsTextField.text!)!
            onCell += 1
        }
        
        print(viewModel)
        success()
    }

}


// MARK: TableView Protocols
extension WorkoutPlanVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.exerciseCell) as! ExerciseTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

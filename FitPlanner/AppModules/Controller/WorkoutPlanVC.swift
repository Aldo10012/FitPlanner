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

protocol WorkoutChangedDelegate {
    func updateWorkoutList()
}

class WorkoutPlanVC: UIViewController {

    // MARK: - Properties    
    var type: WorkoutPlanType!
    var viewModel = WorkoutPlanVM()
    let myData = CoreDataStack.shared
    
    var delegate: WorkoutChangedDelegate!
    
    var workoutNameTextField = FPTextField(placeholder: "Workout name", size: 30, weight: .light)
    var workoutcardView: WorkoutCardView!
    var addExerciseCard = AddExerciseCardView()//FPBackground(radius: 8)
//    var tableView = UITableView()
    var button = FPButton(type: .primary, title: "Button")
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    convenience init(type: WorkoutPlanType, viewModel: WorkoutCardVM) {
        self.init()
        self.type = type
        print("WORKOUT TYPE:", self.type!, "- init")
        modifyViewBasedOnType(viewModel: viewModel)
    }
    
    
    // MARK: Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    

    // MARK: Selectors
    @objc func didTapMarkAsDone() {
//        print("did Tap MarkAsDone")
        viewModel.markWorkoutAsDone()
        Router.popController(self)
    }
    
    @objc func didTapAdd() {
//        print("did Tap Add")
        getViewStateAndPassToViewModel { [self] in
            viewModel.createWorkout()
            delegate.updateWorkoutList()
            Router.popController(self)
        } fail: {
            AlertManager.showFillInExercises(on: self)
        }
    }
    
    @objc func didTapEdit() {
//        print("did Tap Edit")
        getViewStateAndPassToViewModel { [self] in
            viewModel.editWorkout()
            delegate.updateWorkoutList()
            Router.popController(self)
        } fail: {
            AlertManager.showFillInExercises(on: self)
        }
    }
    
    @objc func didTapAddExerciseButton() {
        let newExercise = Exercise(context: myData.persistentContainer.viewContext)
        viewModel.exercises.append(newExercise)
        print("1", viewModel.exercises)
        addExerciseCard.tableView.reloadData()
    }
    
    
    // MARK: - UI Setup
    fileprivate func setupViews() {
        view.backgroundColor = .FPBackground
        title = "Workout Plan"
        
        view.addSubviews(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        scrollView.addSubview(contentView)
        contentView.setWidth(as: scrollView.widthAnchor)
        contentView.setHeight(as: scrollView.heightAnchor)
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingBottom: 150)
        
        
        contentView.addSubviews(workoutNameTextField, workoutcardView, addExerciseCard)
        
        workoutNameTextField.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 30, paddingLeft: 20)
        
        workoutcardView.anchor(top: workoutNameTextField.bottomAnchor, left: contentView.leftAnchor, right: view.rightAnchor,
                               paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        addExerciseCard.addStandardShadow()
        addExerciseCard.anchor(top: workoutcardView.bottomAnchor, left: workoutcardView.leftAnchor, right: workoutcardView.rightAnchor, paddingTop: 30, height: 250)
        
        view.addSubview(button)
        button.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        button.layer.zPosition = 2
        
        addExerciseCard.tableView.delegate = self
        addExerciseCard.tableView.dataSource = self
    }
    
    
    
    // MARK: Check type
    fileprivate func modifyViewBasedOnType(viewModel: WorkoutCardVM) {
        print("WORKOUT TYPE:", self.type!, "- abc")
        switch self.type {
        case .nextWorkout:
//            print(viewModel)
            
            workoutNameTextField.text = viewModel.title
            self.viewModel.object = viewModel.workout
            self.viewModel.exercises = (viewModel.workout.exercises)?.allObjects as [Exercise]
            
            workoutcardView = WorkoutCardView(viewModel: viewModel)
            button.setTitle("Mark as done", for: .normal)
            button.addTarget(self, action: #selector(didTapMarkAsDone), for: .touchUpInside)
            
            if getDateAsString(Date.today()) != getDateAsString(dateOfNextWorkout) {
                button.isEnabled = false
                button.checkPrimaryStatus()
            }
            
            workoutNameTextField.isEnabled = false
            break
        
        case .addWorkout:
//            print(viewModel)

            workoutcardView = WorkoutCardView(viewModel: viewModel)
            button.setTitle("Add", for: .normal)
            button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
            workoutcardView.label.text = "Schedule"
            addExerciseCard.hasAddButton()
            addExerciseCard.addExerciseButton.addTarget(self, action: #selector(didTapAddExerciseButton), for: .touchUpInside)
            makeDayOfWeekButtonsEditable()
            break
            
        case .editWorkout:
            print("viewModel", viewModel.workout.exercises)
            
            self.viewModel.object = viewModel.workout
            self.viewModel.exercises = (viewModel.workout.exercises)?.allObjects as [Exercise]
            

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
        
        // TODO: TableView reshuffles the exercises when u add new one
        
        if viewModel.onSun == false && viewModel.onMon == false && viewModel.onTue == false && viewModel.onWed == false && viewModel.onThu == false && viewModel.onFri == false && viewModel.onSat == false {
            fail(); return
        }
        
        if workoutNameTextField.text == "" { fail(); return }
        
        if viewModel.exercises.count == 0 { fail(); return }
        
        for ex in viewModel.exercises {
            if ex.name == "" || ex.sets == 0 || ex.reps == 0 {
                fail(); return
            }
        }
        
        // setup success case
        print("2", viewModel.exercises)
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
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.delegate = self
        
        print("WORKOUT TYPE:", self.type!, "- ref")
        switch self.type! {
        case .addWorkout:
            print("WORKOUT TYPE: add")
            
        case .editWorkout:
            print("WORKOUT TYPE: edit")
            let object = self.viewModel.exercises[indexPath.row]
            cell.nameTextField.text = object.name
            cell.repsTextField.text = String(object.reps)
            cell.setsTextField.text = String(object.sets)
            
        case .nextWorkout:
            print("WORKOUT TYPE: next")
            let object = self.viewModel.exercises[indexPath.row]
            cell.nameTextField.text = object.name
            cell.repsTextField.text = String(object.reps)
            cell.setsTextField.text = String(object.sets)
            
            cell.nameTextField.isEnabled = false
            cell.repsTextField.isEnabled = false
            cell.setsTextField.isEnabled = false
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

// MARK: Exercise Delegate
extension WorkoutPlanVC: ExerciseDelegate {
    // There methods automatically update the ViewModel when user edits exercise when they are typing
    
    func didUpdateName(indexPath: Int?, name: String?) {
        viewModel.exercises[indexPath!].name = name
        print("a", viewModel.exercises)
    }
    
    func didUpdateSets(indexPath: Int?, sets: Int64?) {
        viewModel.exercises[indexPath!].sets = sets!
        print("b", viewModel.exercises)
    }
    
    func didUpdateReps(indexPath: Int?, reps: Int64?) {
        viewModel.exercises[indexPath!].reps = reps!
        print("c", viewModel.exercises)
    }
    
    
    
}


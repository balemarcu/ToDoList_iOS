//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Marcu Bale on 27.06.2022.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    var toDo: ToDo?
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField){
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDatePicker.date = Date().addingTimeInterval(24*60*60)
        updateDueDateLabel(date: dueDatePicker.date)
        updateSaveButtonState()
        
    }
    
    func updateSaveButtonState(){
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    func updateDueDateLabel(date: Date){
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 200
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        isDatePickerHidden.toggle()
        updateDueDateLabel(date: dueDatePicker.date)
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("breakpoint 1")
        guard segue.identifier == "saveUnwind" else { return }
        print("breakpoint 2")
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesTextView.text
        
        print("The object is: \(title), \(isComplete), \(dueDate), \(String(describing: notes))")
        
        toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
}

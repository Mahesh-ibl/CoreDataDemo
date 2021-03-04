//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by IBL INFOTECH on 04/03/21.
//  Copyright © 2021 IBL INFOTECH. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableViewStudents: UITableView!
    @IBOutlet weak var textfieldRollNo: UITextField!
    @IBOutlet weak var textfieldName: UITextField!
    var students = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }
    
    func fetchStudents() {
        CoreDataUtility.shared.fetchStudents { (resonseStudents) in
            self.students = resonseStudents
        }
    }

    @IBAction func onTapSave(_ sender: Any) {
        CoreDataUtility.shared.insetData(name: textfieldName.text ?? "", rollNo: Int16(textfieldRollNo.text ?? "") ?? 0){ (bSuccess) in
            if bSuccess {
                textfieldRollNo.text = ""
                textfieldName.text = ""
                fetchStudents()
                tableViewStudents.reloadData()
            }
        }
    }
}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        let student = students[indexPath.row]
        cell.selectionStyle = .none
        cell.objectId = student.objectID
        cell.studentActionDelegate = self
        cell.textFieldName.text = student.value(forKey: "name") as? String
        cell.textFieldRollNumber.text = "\(student.value(forKey: "rollNo") as! Int16)"
        return cell
    }

}

extension ViewController:StudentActionDelegate {
    
    func onTapDelete(cell:StudentCell) {
        let indexOfStudent = students.firstIndex(where: {$0.objectID == cell.objectId})
        CoreDataUtility.shared.deleteStudent(object: students[indexOfStudent ?? 0]) { (bSuccess) in
            students.remove(at: indexOfStudent ?? 0)
            tableViewStudents.reloadData()
        }
    }
    
    func onTapUpdate(cell:StudentCell) {
         let indexOfStudent = students.firstIndex(where: {$0.objectID == cell.objectId})
         CoreDataUtility.shared.updateStudentobject(name: cell.textFieldName.text ?? "", rollNo: Int16(cell.textFieldRollNumber.text ?? "") ?? 0, object: students[indexOfStudent ?? 0]) { (bSuccess) in
            cell.textFieldName.endEditing(true)
            cell.textFieldRollNumber.endEditing(true)
            cell.btnUpdate.isEnabled = false
            tableViewStudents.reloadData()
        }
    }
}

//
//  DBHelper.swift
//  CoreDataDemo
//
//  Created by IBL INFOTECH on 04/03/21.
//  Copyright © 2021 IBL INFOTECH. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataUtility {
    
    public static var shared = CoreDataUtility()
    let entity = "Student"
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func insetData(name:String,rollNo:Int16,completion:(Bool) -> Void) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: entity, in: managedContext!)
        let studentData = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        studentData.setValue(name, forKey: "name")
        studentData.setValue(rollNo, forKey: "rollNo")
        
        do {
            try managedContext?.save()
            completion(true)
        } catch let error as NSError {
            print("Data not saved",error.localizedDescription)
        }
    }
    
    func fetchStudents(completion: ([NSManagedObject]) -> Void) {
         let managedContext = appDelegate?.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
         do {
            let result = try managedContext?.fetch(fetchRequest) as? [NSManagedObject]
            completion(result!)
        } catch {
            print("Error while fetching data")
        }
    }
    
    func deleteStudent(object:NSManagedObject, completion : (Bool) -> Void) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        managedContext?.delete(object)
        do {
            try managedContext?.save()
            completion(true)
        } catch {
            print("error : \(error)")
        }
    }
    
    func updateStudentobject(name:String,rollNo:Int16,object:NSManagedObject, completion : (Bool) -> Void) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        object.setValue(name, forKey: "name")
        object.setValue(rollNo, forKey: "rollNo")
        do {
            try managedContext?.save()
            completion(true)
        } catch {
            print("error : \(error)")
        }
        
    }

}

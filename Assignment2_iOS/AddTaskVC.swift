//
//  AddTaskVC.swift
// Assignment2_iOS
//
//  Created by Ankita Jain on 2020-01-21.
//  Copyright © 2020 Ankita Jain. All rights reserved.
//

import UIKit
import CoreData

class AddTaskVC: UIViewController {

    @IBOutlet var textfields : [UITextField]!

         
         var tasks : [Task]?
         weak var delegate : TaskListTableVC?
         
         override func viewDidLoad() {
             super.viewDidLoad()
    
             
             SaveCoreData()

    
             NotificationCenter.default.addObserver(self, selector: #selector(SaveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
             
         }
   
         @IBAction func addTask(_ sender: UIButton) {
             let title1 = textfields[0].text ?? ""
             let days1 = Int(textfields[1].text ?? "0") ?? 0
                        
                     
             let task = Task(title: title1, days: days1)
             tasks?.append(task)
             
                        for textField in textfields {
                             textField.text = ""
                            textField.resignFirstResponder()
                        }
//             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tasktable") as! TaskListTableVC
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
             
            
            
            
                    }
         
         
         override func viewWillDisappear(_ animated: Bool) {
                 
             delegate?.updateArray(taskArray: tasks!)
             
       
             }
             
               
         
         @objc func SaveCoreData(){
             
           
                 clearCoreData()
             
             let appDelegate = UIApplication.shared.delegate as! AppDelegate

             
             let ManagedContext = appDelegate.persistentContainer.viewContext

             for task in tasks!{
                 let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: ManagedContext)
                taskEntity.setValue(task.title, forKey: "title")
                taskEntity.setValue(task.days, forKey: "days")


                 
                 do{
                     try ManagedContext.save()
                 }catch{
                     print(error)
                 }

             }
              LoadCoreData()
            
           
         }

         func LoadCoreData(){

             tasks = [Task]()
             
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate

                    
                    let ManagedContext = appDelegate.persistentContainer.viewContext

             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")

             do{
                 let results = try ManagedContext.fetch(fetchRequest)
                 if results is [NSManagedObject]{
                     for result in results as! [NSManagedObject]{
                         let title = result.value(forKey:"title") as! String

                         let days = result.value(forKey: "days") as! Int


                         tasks?.append(Task(title: title, days: days))

                     }
                 }
             } catch{
                 print(error)
             }
             
           
         }


         func clearCoreData(){
          
          let appDelegate = UIApplication.shared.delegate as! AppDelegate

         
          let ManagedContext = appDelegate.persistentContainer.viewContext

             
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")

             fetchRequest.returnsObjectsAsFaults = false
             do{

                 let results = try ManagedContext.fetch(fetchRequest)
                 for managedObjects in results{
                     if let managedObjectsData = managedObjects as? NSManagedObject{

                         ManagedContext.delete(managedObjectsData)
                     }
                 }
             }
                 catch{
                     print(error)
                 }

         }

     }

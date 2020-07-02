//
//  StoredgeManager.swift
//  CoreDataStudyProject
//
//  Created by Macbook on 01.07.2020.
//  Copyright © 2020 Igor Simonov. All rights reserved.
//

import CoreData

class StoredgeManager {
    
    static let shared = StoredgeManager()
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStudyProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func save(_ taskName: String){
        guard let entityDescription = NSEntityDescription.entity(
            forEntityName: "Task",
            in: persistentContainer.viewContext
            ) else { return }
        guard let task = NSManagedObject(entity: entityDescription,
                                         insertInto: persistentContainer.viewContext) as? Task else { return }
        task.name = taskName
        TaskListViewController.tasks.append(task.self)
        
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //    func delete(_ taskName: String){
    //
    //    }
}

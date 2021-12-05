//
//  DatabaseManager.swift
//  Aasan-ios-todo
//
//  Created by Mohomed Aazaf on 12/5/21.
//  Copyright © 2021 Mohomed Aazaf. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    private let db = Firestore.firestore()
    private lazy var tasksCollection = db.collection("tasks")
    private var listener : ListenerRegistration?

    
    func addTask(_ task: Task, completion: @escaping(Result<Void, Error>) -> Void) {
    
        do{
           _ = try tasksCollection.addDocument(from: task, completion: { (error) in
                   if let error = error {
                       completion(.failure(error))
                   }else{
                       completion(.success(()))
                   }
               })
        }catch (let error){
            completion(.failure(error))
        }
    }
    
    func addTasksListener(completion: @escaping (Result<[Task], Error>) -> Void){
        listener = tasksCollection.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            }else{
                var tasks = [Task]()
                do {
                    tasks = try snapshot?.documents.compactMap({
                    return try $0.data(as: Task.self)
                    }) ?? []
                } catch(let error)  {
                    completion(.failure(error))
                }
                completion(.success(tasks))
            }
        })
    }
    
    func UpdateTaskToDone(id: String,  completion: (Result<[Void], Error>) -> Void){
        
    }
    
    
}

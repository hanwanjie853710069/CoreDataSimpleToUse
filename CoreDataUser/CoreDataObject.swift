//
//  CoreDataObject.swift
//  CoreDataUser
//
//  Created by 王木木 on 16/5/25.
//  Copyright © 2016年 王木木. All rights reserved.
//

import Foundation
import CoreData


/// 被管理的数据上下文   初始化的后，必须设置持久化存储助理
var managedObjectContext: NSManagedObjectContext = {

    let coordinator = persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
}()

/// 持久化存储助理 初始化必须依赖NSManagedObjectModel，之后要指定持久化存储的数据类型，默认的是NSSQLiteStoreType，即SQLite数据库；并指定存储路径为Documents目录下，以及数据库名称
 var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let url = applicationDocumentsDirectory.URLByAppendingPathComponent("CoreData.sqlite")
    var failureReason = "There was an error creating or loading the application's saved data."
    do {
        try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
    } catch {
        var dict = [String: AnyObject]()
        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
        dict[NSLocalizedFailureReasonErrorKey] = failureReason
        
        dict[NSUnderlyingErrorKey] = error as NSError
        let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
        
        NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        abort()
    }
    
    return coordinator
}()

/// Documents目录路径
var applicationDocumentsDirectory: NSURL = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1]
}()


/// 被管理的数据模型  初始化必须依赖.momd文件路径，而.momd文件由.xcdatamodeld文件编译而来
var managedObjectModel: NSManagedObjectModel = {
    print(NSBundle.mainBundle())
    let modelURL = NSBundle.mainBundle().URLForResource("CoreData", withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
}()

///  保存数据到持久层
func saveContext () {
    if managedObjectContext.hasChanges {
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}

//
//  ViewController.swift
//  CoreDataUser
//
//  Created by 王木木 on 16/5/25.
//  Copyright © 2016年 王木木. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        queryData()
        changeData()
        deleteData()
    }
    
    ///  增加数据
    func addData(){
        /*
         增加数据
         */
        /// 生成一个模型类似model
        let contactIonfo = NSEntityDescription.insertNewObjectForEntityForName("Preson", inManagedObjectContext: managedObjectContext) as! Preson
        
        //两种赋值方式 如果你创建了Preson 的NSManagedObjectModel
        //那就可以用点语法调出属性否则只能用setValue赋值
        
        //点语法赋值
        contactIonfo.age = 12
        contactIonfo.name = "wangmumu"
        
        //setValue赋值
        //contactIonfo .setValue("1", forKey: "name")
        //contactIonfo .setValue(11, forKey: "age")
        
        ///  保存到本地
        saveContext()
    }
    
    ///  查询数据
    func queryData(){
        
        ///查询数据
        ///  返回一个查询对象
        let fetchRequest = NSFetchRequest.init()
        ///  生成一个要查询的表的对象
        let entity = NSEntityDescription.entityForName("Preson", inManagedObjectContext: managedObjectContext)
        ///  查询对象属性
        fetchRequest.entity = entity
        ///  判断查询对象是否为空 防止崩溃
        if (entity != nil) {
            ///  查询结果
            do{
                /// 成功
                let qwqwrr:[AnyObject]?  = try managedObjectContext.executeFetchRequest(fetchRequest)
                for info:NSManagedObject in qwqwrr as![NSManagedObject] {
                    print(info)
                }
            }catch{
                /// 失败
                fatalError("查询失败：\(error)")
            }
        }else{
            ///  查询对象不存在
            print("查询失败：查询不存在")
        }
    }
    
    ///  修改数据
    func changeData(){
        ///修改数据  
        ///先查询到要修改内容然后在修改数据
        ///  返回一个查询对象
        let fetchRequest = NSFetchRequest.init()
        ///  生成一个要查询的表的对象
        let entity = NSEntityDescription.entityForName("Preson", inManagedObjectContext: managedObjectContext)
        ///  查询对象属性
        fetchRequest.entity = entity
        ///  判断查询对象是否为空 防止崩溃
        if (entity != nil) {
            ///  查询结果
            do{
                /// 成功
                ///两种方法  0有Preson对象时和1没有的时候
                let temp:[AnyObject]  = try managedObjectContext.executeFetchRequest(fetchRequest)
                //1没有对象时
                #if false
                for info:NSManagedObject in temp as![NSManagedObject] {
                    info.setValue("wmm", forKey: "name")
                }
                #else
                    //0有对象时
                    for info:Preson in temp as![Preson] {
                        info.name = "wmm"
                    }
                #endif
            }catch{
                /// 失败
                fatalError("修改失败：\(error)")
            }
        }else{
            ///  查询对象不存在
            print("查询失败：查询不存在")
        }
    }
    
    ///  删除数据
    func deleteData(){
        ///删除数据
        ///先查询到要修改的内容然后删除
        ///  返回一个查询对象
        let fetchRequest = NSFetchRequest.init()
        ///  生成一个要查询的表的对象
        let entity = NSEntityDescription.entityForName("Preson", inManagedObjectContext: managedObjectContext)
        ///  查询对象属性
        fetchRequest.entity = entity
        ///  判断查询对象是否为空 防止崩溃
        if (entity != nil) {
            ///  查询结果
            do{
                /// 成功
                ///两种方法  0有Preson对象时和1没有的时候
                let temp:[AnyObject]  = try managedObjectContext.executeFetchRequest(fetchRequest)
                    for info:Preson in temp as![Preson] {
                        if info.name == "wmm" {
                            //删除对象
                            managedObjectContext.deleteObject(info)
                        }
                    }
            }catch{
                /// 失败
                fatalError("删除失败：\(error)")
            }
        }else{
            ///  查询对象不存在
            print("查询失败：查询不存在")
        }
        ///删除成功后再次保存到本地
        saveContext()
    }
    
}


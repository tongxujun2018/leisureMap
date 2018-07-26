//
//  FileWorker.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 tripim. All rights reserved.
//

import Foundation


class FileWorkerDelegate{
   
    
    func fileWorkWriteCompleted(_sender:FileWorker,fileName:String,tag:Int)
    func fileWorkReadCompleted(_sender:FileWorker,fileName:String,tag:Int)
    
    var FileWorkerDelegate:FileWorkerDelegate?
    func writeToFile(content:String,fileName:String,tag:Int){
        
        if let dir = FileManager.default.urls(for: .documentDirectory,in:.userDomainMask).first{
    let fileURL=dir.appendingPathComponent(fileName)
            do{
          try content.write(to: fileURL, atomically: false, encoding: .utf8)
                self.FileWorkerDelegate?.fileWorkWriteCompleted(self,fileName:fileURL.absoluteString,tag:tag)
        
        }
            catch{print(error)}
    }
    func readFromFile(fileName:String,tag:Int)->String{
        var result:String=""
        
        
        return result
            
        }
        
    
}


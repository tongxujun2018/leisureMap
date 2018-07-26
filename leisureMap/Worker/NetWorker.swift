//
//  NetWorker.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 tripim. All rights reserved.
//

import Foundation
protocol AsyncRequestDelgate{
    func receviedReponse(_sender: AsyncRequestWorker,responseString : String,tag : Int ) -> Void
}


class AsyncRequestWorker{
    var responseDelegate: AsyncRequestDelgate?
    
    func getResponse(from:String,tag:Int) -> Void {
    
        let url = URL(string: from)!
        let request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        let task = session.dataTask(with: request,completionHandler:{(data,response,error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (200 == statusCode){
                
                let dataString = NSString(data:data!,encoding:String.Encoding.utf8.rawValue)
                
                let responseString = String(dataString!)
                
                self.responseDelegate?.receviedReponse(_sender: self, responseString: responseString, tag: tag)
            }
            
            
        })
        task.resume()
    
    
    
   
    
    
    }



}

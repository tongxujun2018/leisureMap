


//
//  loginViewController.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import SwiftyJSON

class loginViewController: UIViewController ,UITextFieldDelegate,AsyncRequestDelgate,FileWorkerDelegate{
   
    
    
    
    
    
 
    
    
    @IBOutlet weak var txtaccount: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    
    var requestWorker:AsyncRequestWorker?
    var fileWorker: FileWorker?
    let storeFileName: String="store.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
        requestWorker=AsyncRequestWorker()
        requestWorker?.responseDelegate = self
        fileWorker=FileWorker()
        fileWorker?.FileWorkerDelegate = self
        
        print("viewDidload")
//        let from = "https://score.azurewebsites.net/api/login/"
//        self.requestWorker?.getResponse(from: from, tag:1)


        //https://score.azurewebsites.net/api/login/acc/pwd
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let  account=txtaccount.text!
        let  password=txtpassword.text!
        
        
        
        let from = "https://score.azurewebsites.net/api/login/\(account)/\(password)"
        
        self.requestWorker?.getResponse(from: from, tag: 1)
    
    }
    
    func readServieCategory() {
        let from = "https://score.azurewebsites.net/api/ServiceCategory"
        self.requestWorker?.getResponse(from: from, tag: 2)
    }
    
    func readStore() {
        let from = "https://score.azurewebsites.net/api/Store"
        self.requestWorker?.getResponse(from: from, tag: 3)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewDidDisappear")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let accept="abcdeABCDE"
        let cs=NSCharacterSet(charactersIn: accept).inverted
        
        let filtered=string.components(separatedBy: cs).joined(separator: "")
        
        if (string != filtered){
            return false
        }
        
        
        var maxlength : Int=0
        
        if textField.tag==1{
           maxlength=12
        }
        if  textField.tag==2{
          
          maxlength=8
    }
        
        let currentstring:NSString=textField.text!as NSString
        
        let newString:NSString=currentstring.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxlength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag==1{
            textField.resignFirstResponder()
            txtpassword.becomeFirstResponder()
        }
        if  textField.tag==2{
            textField.resignFirstResponder()
        }
        return true
    }

    func receviedReponse(_sender: AsyncRequestWorker, responseString: String, tag: Int) {
        
      //  print("\( tag ):\(responseString)")
        
        switch tag {
            
        case 1:
            //login
            self.readServieCategory()
            break
        case 2:
            
            //ServiceCategory
            
            do{
                if let dataFromString = responseString.data(using: .utf8, allowLossyConversion: false) {
                    
                    let json = try JSON(data: dataFromString)
                    
                    let sqliteContext = SQLiteWorker()
                    sqliteContext.createDatabase()
                    sqliteContext.clearAll()
                    

                    for (_ ,subJson):(String, JSON) in json {
                        
                        let store:Store=Store()
                        
                        let serviceIndex:Int=subJson["serviceIndex"].intValue
                        let name:String=subJson["name"].stringValue
                        let index:Int=subJson["index"].intValue
                        let imagePath : String  = subJson["imagePath"].stringValue
                        
                        
                        let location:JSON = subJson["location"]
                        let address:String = location["address"].stringValue
                        let latitude:Double = location["latitude"].doubleValue
                        let longitude:Double = location["longitude"].doubleValue

                        store.ServiceIndex = serviceIndex
                        store.Name = name
                        store.Index = index
                        store.ImagePath = imagePath

                        store.StoreLocation=LocationDesc()
                        store.StoreLocation?.Address=address
                        store.StoreLocation?.LaTitude=latitude
                        store.StoreLocation?.Longitude=longitude
                        
                        sqliteContext.insertData(_name: name, _imagepath: imagePath)
                    }
                       
//                    let categories=sqliteContext.readData()
//                    print(categories)
                    
                }
            }catch{
                
                print(error)
            }
            
            
            self.readStore()
            break

        case 3:
            //
            

            self.fileWorker?.writeToFile(content: responseString, fileName: storeFileName, tag: 1)
            
            break
        default:
            break
        }
     
    }
    
    //MARK:-
    func fileWorkWriteCompleted(_ sender: FileWorker, fileName: String, tag: Int) {
       print(fileName)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moveTomasterviewsegue", sender: self)
        }
    }
    
    func fileWorkReadCompleted(_ sender: FileWorker, content: String, tag: Int) {
        
    }
}

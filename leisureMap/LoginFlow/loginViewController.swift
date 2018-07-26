


//
//  loginViewController.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class loginViewController: UIViewController ,UITextFieldDelegate,AsyncRequestDelgate{
    func receviedReponse(_sender: AsyncRequestWorker, responseString: String, tag: Int) {
        print(responseString)
    }
    
    
    @IBOutlet weak var txtaccount: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    
    var requestWorker:AsyncRequestWorker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        requestWorker=AsyncRequestWorker()
        requestWorker?.responseDelegate=self
        
        let from = "https://score.azurewebsites.net/api/login/"
        self.requestWorker?.getResponse(from: from, tag:1)


        //https://score.azurewebsites.net/api/login/acc/pwd
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginClicked(_ sender: UIButton) {
        let  account=txtaccount.text!
        let  password=txtpassword.text!
        
        
        
        let from = "https://score.azurewebsites.net/api/login/\(account)/\(password)"
        
        self.requestWorker?.getResponse(from: from, tag: 1)
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

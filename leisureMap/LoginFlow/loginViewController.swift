


//
//  loginViewController.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class loginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var txtaccount: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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




//
//  detailViewController.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    var selectedStore: Store?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title=selectedStore?.Name
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnmapclicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "movetomap", sender: self)
        }
    }
    @IBAction func btnwebclicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "movetonote", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "movetomap":
            
            break
            
        case "movetonote":
            
            break
        default:
            break
        }
    }
   

}

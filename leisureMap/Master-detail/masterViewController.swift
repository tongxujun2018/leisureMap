//
//  masterViewController.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import SwiftyJSON


class masterViewController: UIViewController ,FileWorkerDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var storeTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let store = displayStores[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCellView", for: indexPath) as! StoreCellView
        
        cell.updateContent(store: store)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let store = displayStores[indexPath.row]
        
        self.selectedStore = store
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moveToDetailViewSegue", sender: self)
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cagegory = categories[indexPath.row]
        
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCellView", for: indexPath) as! ServiceCellView
        
        cell.updateContent(service: cagegory)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cagegory = categories[indexPath.row]
        displayStores.removeAll()
        for store in stores{
            let idx : Int = cagegory.Index-1
            if(store.ServiceIndex == idx ){
                displayStores.append(store)
            }
            DispatchQueue.main.async {
            self.storeTable.reloadData()
                
                
                
                
            }
            
            
        }
        
    }
    
    
    
    
    func fileWorkWriteCompleted(_ sender: FileWorker, fileName: String, tag: Int) {

    }

    func fileWorkReadCompleted(_ sender: FileWorker, content: String, tag: Int) {

    }

    var fileWorker: FileWorker?
    let storeFileName: String="store.json"

    var categories:[ServiceCategory] = []
    var stores:[Store] = []
    var displayStores:[Store]=[]
    var selectedStore:Store?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fileWorker = FileWorker()
        fileWorker?.FileWorkerDelegate = self
        
        let sqliteContext = SQLiteWorker()
        let categoriesInSQLite = sqliteContext.readData()
        categories = categories + categoriesInSQLite
       
        let content = self.fileWorker?.readFromFile(fileName: storeFileName, tag: 1)
        
        do{
            if let dataFromString = content?.data(using: .utf8, allowLossyConversion: false) {

                let json = try JSON(data: dataFromString)
                
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
                    
                    
                    stores.append(store)
                }
            }
        }catch{
            print(error)
        }
        
        displayStores = displayStores + stores
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "moveToDetailViewSegue":
            let viewController = segue.destination as! detailViewController
            viewController.selectedStore = self.selectedStore
            
            
            break
        default:
            break
        }
    }

}

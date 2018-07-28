//
//  mapViewController.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation






class mapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance =  1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            
            locationManager.desiredAccuracy =
kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            
            }
        
        
        
        mapView.delegate = self
        mapView.showsUserLocation = true
   
        //centerMapOnLocation(loction.coordinate,)
        
        
//        let flag = MapFlag(title:"ios app by swift",locationName:"abc",discipline:"apple room",coordinate:CLLocationCoordinate2D(latitude:31.29065118 , longitude: 118.368044))
        
        let flag = MapFlag(title: "ios app by swift", locationName: "abc", discipline: "apple room", coordinate: CLLocationCoordinate2D(latitude:31.29075118 , longitude: 118.3625587), url: "https://apple.com")
        
        mapView.addAnnotation(flag)
        
        // Do any additional setup after loading the view.
    }
  
    func centerMapOnLocation(loction: CLLocation){
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(loction.coordinate, regionRadius,regionRadius)
        
        mapView.setRegion(coordinateRegion,animated:true)
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard let locValue :  CLLocationCoordinate2D = manager.location?.coordinate  else{
           
            return
            
        }
        
        print("latitude:\(locValue.latitude):longitude:\(locValue.longitude)")
        centerMapOnLocation(loction: manager.location!)
        
    }
    
    @objc func moveToWebView(sender : UIButton ){
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapFlag else{
            return nil
        }
        
        
        let identifier = "marker"
        let annotationView : MKAnnotationView
        
        if let dequeueView =  mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            
            dequeueView.annotation = annotation
            annotationView = dequeueView
            
        }else{
            
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout=true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            
            let button = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = button
            
            button.addTarget(self, action: #selector(self.moveToWebView(sender:)), for: .touchUpInside)
        }
        return annotationView
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

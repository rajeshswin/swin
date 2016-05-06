//
//  ViewController.swift
//  Map
//
//  Created by SWDEVMAC-1 on 05/05/16.
//  Copyright © 2016 SWDEVMAC-1. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
   
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
//        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", subinfo:"Sub")
//        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", subinfo:"Sub")
//        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", subinfo:"Sub")
//        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", subinfo:"Sub")
        
        self.dropPinAnnotation(51.507222, longitude: -0.1275, Title: "London", Subtitle: "sub")
        self.dropPinAnnotation(59.95, longitude: 10.75, Title: "oslo", Subtitle: "sub")
        self.dropPinAnnotation(48.8567, longitude: 2.3508, Title: "Paris", Subtitle: "sub")
        self.dropPinAnnotation(41.9, longitude: 12.5, Title: "rome", Subtitle: "sub")
        self.dropPinAnnotation(38.895111, longitude: -77.036667, Title: "WashingMachine DC", Subtitle: "sub")
        
        self.dropPinAnnotation(34.0150, longitude: 71.5805, Title: "Pakistan", Subtitle: "Peshawar")
        
        
        
        
 
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            
//            pinAnnotationView.pinColor = .Purple
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
//            pinAnnotationView.animatesDrop = true
            
             
            
            
            pinAnnotationView.image = UIImage(named: "pin.png")
            
            let deleteButton = UIButton(type: UIButtonType.Custom) as UIButton
            deleteButton.frame.size.width = 44
            deleteButton.frame.size.height = 44
            deleteButton.backgroundColor = UIColor.redColor()
            deleteButton.setImage(UIImage(named: "echozen.png"), forState: .Normal)
            
            pinAnnotationView.leftCalloutAccessoryView = deleteButton
            
            return pinAnnotationView
        }
        
        return nil
    }
    func addRadiusCircle(location: CLLocation){
        self.mapView.delegate = self
        let circle = MKCircle(centerCoordinate: location.coordinate, radius: 10000 as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return nil
        }
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        NSLog("call***********************")
        
        let nextController = self.storyboard?.instantiateViewControllerWithIdentifier("DidSelectViewController") as! DidSelectViewController
        
        self.presentViewController(nextController, animated: true, completion: nil)
        
        
    }
    
    
    func dropPinAnnotation(latitude : CLLocationDegrees, longitude: CLLocationDegrees, Title : String, Subtitle : String)
    {
        let initialLocation = CLLocationCoordinate2DMake(latitude,longitude)
        let pindrop = MKPointAnnotation()
        pindrop.coordinate = initialLocation
        pindrop.title = Title
        pindrop.subtitle = Subtitle
        
        mapView.addAnnotation(pindrop)
        
        
        let overlay:MKCircle = MKCircle(centerCoordinate: initialLocation, radius: 100)
        
        self.mapView(mapView, rendererForOverlay: overlay)
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegionMake(initialLocation, span)
        
        
        mapView.addOverlay(overlay)
        
          mapView.setRegion(region, animated: true)
        
        
       
        let location = CLLocation(latitude: latitude as CLLocationDegrees, longitude: longitude as CLLocationDegrees)
        
        addRadiusCircle(location)
        
        
     
        
        
        
        

    }
    
    
    
   

    
}

//
//  ViewController.swift
//  GMapsDemo
//
//  Created by Gabriel Theodoropoulos on 29/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class ViewController: UIViewController {

    @IBOutlet weak var viewMap: GMSMapView!
    
    @IBOutlet weak var bbFindAddress: UIBarButtonItem!
    
    @IBOutlet weak var lblInfo: UILabel!
    var likelyPlaces:[Any]?
    var placeClient:GMSPlacesClient?
    var selectedMarker:GMSMarker?
    var customView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating a camera
        
        let camera = GMSCameraPosition.camera(withLatitude: 23.431351, longitude: 85.325879, zoom: 6.0)
        //viewMap = GMSMapView.map(withFrame: viewMap.frame, camera: camera)
        
        self.viewMap = GMSMapView.map(withFrame: viewMap.frame, camera: camera)
        self.viewMap.delegate = self
        self.viewMap.mapType = .normal
        self.viewMap.settings.myLocationButton = true
        
        do{
            if let styleURL = Bundle.main.url(forResource: "night", withExtension: "json"){
                self.viewMap.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }else{
                print("unable to find json")
            }
            
        }catch{
            print("one more map style failed")
        }
    
    }

    func listLikelyPlaces(){
        self.likelyPlaces?.removeAll()
        self.placeClient?.currentPlace(callback: {(placeLikelyHoods,error) -> Void in
            if let error = error {
                print("Current place:\(error.localizedDescription)")
                return
            }
            
            if let likeliHoodList = placeLikelyHoods {
                for likelihood in likeliHoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces?.append(place)
                  //  GMSMapUtils.addMarker(for:place,at:self.viewMap)
                }
            }
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    // MARK: IBAction method implementation
    
    @IBAction func changeMapType(sender: AnyObject) {
        
    }
    
    
    @IBAction func findAddress(sender: AnyObject) {
       self.performSegue(withIdentifier: "LocalizedSegue", sender: self)
    }
    
    
    @IBAction func createRoute(sender: AnyObject) {
    
    }
    
    
    @IBAction func changeTravelMode(sender: AnyObject) {
    
    }
    
    
}

extension ViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.selectedMarker = marker
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        if let marker = self.selectedMarker {
            self.customView?.center = self.viewMap.projection.point(for: marker.position)
            //self.customView?.center.y -=
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
       
    }
}

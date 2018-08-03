//
//  MapViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/1/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit
import AnnotationETA
import CoreLocation
import MapKit
import CountdownLabel
import SwiftMessages
import GoogleMaps
import GooglePlaces
import SVProgressHUD
class MapViewController: UIViewController,ISHPullUpContentDelegate, MKMapViewDelegate,GMSMapViewDelegate{
    var users = [User]()
    var oldUsers = [User]()
    var oldMarkers = [GMSMarker]()
    var newMarkers = [GMSMarker]()

    var timer = Timer()
    @IBOutlet weak var mapSubView: UIView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    var zoomLevel: Float = 16.0
    var camera = GMSCameraPosition()
    
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var timeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        placesClient = GMSPlacesClient.shared()
        // add counter label
        let fromDate   = NSDate().addingTimeInterval(100)
        let targetDate = fromDate.addingTimeInterval(400)
        let countdownLabel = CountdownLabel(frame: CGRect(x: 20, y: 0, width: 132, height: 35), fromDate: fromDate, targetDate: targetDate)
        countdownLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 22)
        countdownLabel.start()
         self.timeView.addSubview(countdownLabel)
        let camera = GMSCameraPosition.camera(withLatitude: 21.4231666658504 , longitude: 39.8258475814949, zoom: zoomLevel)
        self.mapView.camera = camera
       // self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        do {
            // Set the map style by passing the URL of the local file.
            if mapView != nil{
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                self.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        self.mapView?.isMyLocationEnabled = true
        self.mapView.isBuildingsEnabled = true
        self.mapView.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.1273266375, alpha: 1)
        
        SVProgressHUD.show()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.timer = Timer.scheduledTimer(timeInterval: 2.0,
                                          target: self,
                                          selector: #selector(readUsersJSON),
                                          userInfo: nil,
                                          repeats: true)
        self.mapView.bringSubview(toFront: timerView)
        self.mapView.bringSubview(toFront: distanceView)

    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController contentVC: UIViewController) {
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets = edgeInsets
            view.layoutMargins = .zero
        } else {
           view.layoutMargins = edgeInsets
        }
        view.layoutIfNeeded()
    }
    
    
    @objc func readUsersJSON(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //self.mapView.clear()
        ServiceManager().getUsers(status: appDelegate.isFirstAppOpen) { (users, error) in
            if  error == nil {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.users = users!
                    if self.oldUsers.count == 0{
                        self.oldUsers = users!
                    }
                    if appDelegate.isFirstAppOpen{
                        appDelegate.isFirstAppOpen = false
                        self.setStaticData()
                    }
                    else{
                        self.updateLocations()
                    }
                }
            }
            else{
                print("error"+(error?.localizedDescription)!)
            }
        }
        
        
    }
    func getReportedUsersNames() -> [String] {
        var names = [String]()
        for user in users{
            if user.hasReported{
                names.append(user.fullName)
            }
        }
        return names
    }
    func updateLocations(){
        newMarkers = [GMSMarker]()
        for i in (0..<users.count){
            let user = users[i]
            let oldUser = oldUsers[i]
            let long = Double(user.longitude)
            let lat = Double(user.latitude)
            let oldLong = Double(oldUser.longitude)
            let oldLat = Double(oldUser.latitude)
            let newcoordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            let oldcoordinate = CLLocationCoordinate2D(latitude: oldLat!, longitude: oldLong!)
            var image = #imageLiteral(resourceName: "greenAnnotation")
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            var status = "Active"
            if user.outOfRange == true{
                status = "Lost"
                imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 38)
                image = #imageLiteral(resourceName: "redAnnotation")
            }
            imageView.image = image
            let marker = oldMarkers[i]
            marker.map = nil
            marker.position = newcoordinate
//            let neMarker = GMSMarker(position: newcoordinate)
            marker.title = user.fullName
            marker.snippet = status
            marker.iconView = imageView
            marker.map = self.mapView
            newMarkers.append(marker)
            self.mapView.camera = GMSCameraPosition.camera(withLatitude: lat! , longitude: long!, zoom: zoomLevel)

            if user.hasReported != true && user.outOfRange{
                let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
                messageView.configureContent(title: user.fullName + "  is out of range", body: "")
                messageView.button?.isHidden = false
                messageView.button?.setTitle("Call Me", for: .normal)
                messageView.iconLabel?.isHidden = true
                messageView.iconImageView?.isHidden = false
                messageView.iconImageView?.image = #imageLiteral(resourceName: "rPlaceholder")
                messageView.preferredHeight = 80
                messageView.button?.addTarget(self, action: #selector(self.callBtnAction), for: .touchUpInside)
                messageView.button?.tag =  Int(user.mobile)!
                messageView.configureTheme(backgroundColor: .red, foregroundColor: .white)
                messageView.configureDropShadow()
                messageView.configureBackgroundView(width: UIScreen.main.bounds.size.width)
                var config = SwiftMessages.defaultConfig
                config.presentationStyle = .top
                config.presentationContext = .viewController(self)
                SwiftMessages.show(config: config, view: messageView)
            }
        }
        oldMarkers = newMarkers
        oldUsers = self.users
    }
    func setStaticData(){
        
        var i = 0.0
        for user in self.users{
            i = i + 0.004
            var image = #imageLiteral(resourceName: "greenAnnotation")
            var status = "Active"
            if user.outOfRange == true{
                status = "Lost"
                image = #imageLiteral(resourceName: "redAnnotation")
            }
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imageView.image = image
            let marker = GMSMarker()
            let long = Double(user.longitude)
            let lat = Double(user.latitude)
            
            marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            marker.title = user.fullName
            marker.snippet = status
            marker.iconView = imageView
            marker.map = mapView
            oldMarkers.append(marker)
            
                        if user.hasReported != true && user.outOfRange{
                            let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
                            messageView.configureContent(title: user.fullName + "  is out of range", body: "")
                            messageView.button?.isHidden = false
                            messageView.button?.setTitle("Call Me", for: .normal)
                            messageView.iconLabel?.isHidden = true
                            messageView.iconImageView?.isHidden = false
                            messageView.iconImageView?.image = #imageLiteral(resourceName: "rPlaceholder")
                            messageView.preferredHeight = 80
                            messageView.button?.addTarget(self, action: #selector(self.callBtnAction), for: .touchUpInside)
                            messageView.button?.tag =  Int(user.mobile)!
                            messageView.configureTheme(backgroundColor: .red, foregroundColor: .white)
                            messageView.configureDropShadow()
                            messageView.configureBackgroundView(width: UIScreen.main.bounds.size.width)
                            var config = SwiftMessages.defaultConfig
                            config.presentationStyle = .top
                            config.presentationContext = .viewController(self)
                            SwiftMessages.show(config: config, view: messageView)
                            }
        }
        
    }
    
    @objc func callBtnAction(sender:UIButton){
        guard let number = URL(string: "tel://" + String(sender.tag)) else { return }
        
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
}
extension MapViewController: CLLocationManagerDelegate {
    //Heading
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        //        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
        //                                              longitude: location.coordinate.longitude,
        //                                              zoom: zoomLevel)
        //
        //        if mapView.isHidden {
        //            mapView.isHidden = false
        //            mapView.camera = camera
        //        } else {
        //            mapView.animate(to: camera)
        //        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    // UpdteLocationCoordinate
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        
        
    }
    // MARK: - ARCarMovementDelegate
//    func arCarMovement(_ movedMarker: GMSMarker) {
//        driverMarker = movedMarker
//        driverMarker.map = mapView
//
//        //animation to make car icon in center of the mapview
//        //
//        let updatedCamera = GMSCameraUpdate.setTarget(driverMarker.position, zoom: 15.0)
//        mapView.animate(with: updatedCamera)
//    }
}

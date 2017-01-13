//
//  YZYKLocationManager.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import CoreLocation

class YZYKLocationManager: NSObject, CLLocationManagerDelegate {

    static let share = YZYKLocationManager()
    private var manager: CLLocationManager!
    private var locationServicesEnabled: Bool = true
    private var currentCoordinate: CLLocationCoordinate2D!
    private override init() {
        super.init()
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 100
        manager.delegate = self
        if !CLLocationManager.locationServicesEnabled() {
            locationServicesEnabled = false
        }else{
            if CLLocationManager.authorizationStatus() == .notDetermined {
                manager.requestWhenInUseAuthorization()
            }
        }
    }
    
    public func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    public func getLocationCoordinate2D(location:((Bool,String,String) ->Void)?) {
        let lat = String(format: "%.6f", currentCoordinate.latitude)
        let lot = String(format: "%.6f", currentCoordinate.longitude)
        location?(locationServicesEnabled,lat,lot)
    }
    
//MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            currentCoordinate = locations.first?.coordinate
        }else{
            currentCoordinate = CLLocationCoordinate2DMake(0, 0)
        }
    }
    
}

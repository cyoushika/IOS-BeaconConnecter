//
//  ViewController.swift
//  CoreLocationTester
//
//  Created by zhangzhihua on 2017/3/21.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    
    let uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    var MyBeaconRegion:BeaconID!
    var beaconUUID: UUID!
    var minorID = 0
    var majorID = 0
    var rssi = 0
    var proximity = ""
    //var beaconRegionArray = [CLBeaconRegion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        MyBeaconRegion = BeaconID(uuidString: uuid, major: 53960, minor: 191)
        
        startMonitoringItem(item: MyBeaconRegion)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beaconRegionWithItem(item: BeaconID) -> CLBeaconRegion
    {
        let beaconRegion = CLBeaconRegion(proximityUUID: item.uuid, major: item.major, minor: item.minor, identifier: item.asString)
        return beaconRegion
    }
    
    func startMonitoringItem(item: BeaconID)
    {
        print("Let's start Monitoring!")
        let beaconRegion = beaconRegionWithItem(item: item)
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func stopMonitoringItem(item: BeaconID)
    {
        print("Let's stop Monitoring!")
        let beaconRegion = beaconRegionWithItem(item: item)
        locationManager.stopMonitoring(for: beaconRegion)
        locationManager.stopRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Location manager failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error)
    {
        print("Failed monitoring region: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Failed ranging the Beacon:\(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        print("We didn't finish the update successfully:\(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        if(beacons.count > 0)
        {
            for i in 0 ..< beacons.count
            {
                print("Hi! I found One here!")
                
                let myBeacon = beacons[i]
                beaconUUID = myBeacon.proximityUUID
                minorID = Int(myBeacon.minor)
                majorID = Int(myBeacon.major)
                rssi = myBeacon.rssi
                
                //print("The UUID is \(beaconUUID)\nThe major is \(majorID),the minor is \(minorID)\nAnd the RSSI is \(rssi)")
                switch(myBeacon.proximity){
                case CLProximity.far:
                    proximity = "far"
                    break
                case CLProximity.near:
                    proximity = "near"
                    break
                case CLProximity.immediate:
                    proximity = "immediate"
                    break
                default:
                    proximity = "Unknown"
                }
                //print("The proximity is \(proximity)")
                
                print("i = \(i)")
                print("count = \(beacons.count)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            locationManager.startUpdatingLocation()
        }
        else
        {
            print("This app needs the Location and it can't be used when the location service is OFF")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Hi,there,welcome to my world!")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Goodbye, hope to see you again!")
    }
    
}

//
//  Beacons.swift
//  ios
//
//  Created by Jorge Izquierdo on 29/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import Foundation
import CoreLocation

class Beacons: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var beaconRegion = CLBeaconRegion()
    
    var foundBeacon = false
    var callback: ((beaconId: String) -> ())?
    
    func start(cb: (beaconId: String) -> ()){
        
        self.callback = cb
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        var uuid = NSUUID(UUIDString: "D9B9EC1F-3925-43D0-80A9-1E39D4CEA95D")
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "thei bicon")
        
        self.beaconRegion.notifyOnEntry = true
        self.beaconRegion.notifyEntryStateOnDisplay = true
        self.beaconRegion.notifyOnExit = true
        
        self.locationManager.startMonitoringForRegion(beaconRegion)
        self.locationManager.startRangingBeaconsInRegion(self.beaconRegion)
        self.locationManager.requestStateForRegion(self.beaconRegion)
        
        println("monitoring for beacon", CLLocationManager.authorizationStatus().rawValue)
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        println("hola")
        if beacons.count > 0 {
            if !foundBeacon {
                self.callback?(beaconId: "\(beacons[0].major).\(beacons[0].minor)")
                self.foundBeacon = true
            }
        }
    }

}


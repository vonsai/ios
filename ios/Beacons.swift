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

    override init(){
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
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
        println("st \(state)")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        if beacons.count > 0 {
            let b = beacons[0] as CLBeacon
            println("Got b \(b)")
        }
    }

}


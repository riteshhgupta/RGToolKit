//
//  LocationService.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 10/12/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

public class LocationService: NSObject {

	public struct Data {
		var location: CLLocation?
		let status: CLAuthorizationStatus
	}
	
	public var locationHandler: Closure<Data, Void>?
	
	let cllocationManager: CLLocationManager = CLLocationManager()
	let hasBackgroundPermission: Bool
	let shouldUpdateContinously: Bool
	
	public init(withBackgroundPermission permission: Bool, shouldUpdateContinously should: Bool = true) {
		self.hasBackgroundPermission = permission
		self.shouldUpdateContinously = should
		
		super.init()
		
		self.cllocationManager.delegate = self
		self.cllocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
	}
	
	public var permissionAllowed: Bool {
		let authStatus = CLLocationManager.authorizationStatus()
		return (authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways)
	}
	
	public func currentLocation(_ handler: @escaping Closure<Data, Void>) {
		locationHandler = handler
		startFetchingLocation()
	}
}

extension LocationService {
	
	func startFetchingLocation() {
		let authStatus = CLLocationManager.authorizationStatus()
		switch authStatus {
		case .notDetermined:
			askForPermission()
		case .restricted, .denied:
			handleLocationFetchFailure()
		case .authorizedWhenInUse, .authorizedAlways:
			cllocationManager.startUpdatingLocation()
		}
	}

	func askForPermission() {
		if hasBackgroundPermission {
			cllocationManager.requestAlwaysAuthorization()
		} else {
			cllocationManager.requestWhenInUseAuthorization()
		}
	}
	
	func handleLocationFetchFailure() {
		let status = CLLocationManager.authorizationStatus()
		let data = LocationService.Data(location: nil, status: status)
		locationHandler?(data)
	}
}

extension LocationService: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let status = CLLocationManager.authorizationStatus()
			let data = LocationService.Data(location: location, status: status)
			locationHandler?(data)
			
			if !shouldUpdateContinously {
				manager.stopUpdatingLocation()
				locationHandler = nil
			}
		}
	}
	
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedAlways || status == .authorizedWhenInUse {
			manager.startUpdatingLocation()
		} else {
			manager.stopUpdatingLocation()
		}
	}
	
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		handleLocationFetchFailure()
	}
}

extension LocationService {
	func fetchAddress(forLocation location: CLLocation, handler: @escaping Closure<String, Void>) {
		CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
			var values = [String]()
			let addressDict = placemarks?[0].addressDictionary
			values += addressDict?["SubLocality"]
			values += addressDict?["City"]
			let value = values.combineSeparatedBy(", ")
			handler(value)
		})
	}
}

func +=(left: inout [String], right: Any?) {
	if let right = right as? String {
		left.append(right)
	}
}

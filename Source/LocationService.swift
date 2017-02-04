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

public protocol LocationServiceProtocol {

	var needBackgroundPermission: Bool { get }
	var needContinousUpdates: Bool { get }
	var allowsBackgroundLocationUpdates: Bool { get }
	var shouldMonitorSignificantChanges: Bool { get }
	var distanceFilter: CLLocationDistance? { get }
}

public extension LocationServiceProtocol {
	
	var needBackgroundPermission: Bool { return false }
	var needContinousUpdates: Bool { return false }
	var allowsBackgroundLocationUpdates: Bool { return false }
	var shouldMonitorSignificantChanges: Bool { return false }
	var distanceFilter: CLLocationDistance? { return nil }
}

extension LocationService: LocationServiceProtocol {}

open class LocationService: NSObject {
	
	public struct Data {
		public var location: CLLocation?
		public let status: CLAuthorizationStatus
	}
	
	public var locationHandler: Closure<Data, Void>?
	
	public let cllocationManager: CLLocationManager
	
	public override init() {
		self.cllocationManager = CLLocationManager()
		super.init()
		distanceFilter.then { self.cllocationManager.distanceFilter = $0 }
		cllocationManager.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates
		startLocationUpdates()
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

fileprivate extension LocationService {
	
	func startLocationUpdates() {
		cllocationManager.delegate = self
		if shouldMonitorSignificantChanges {
			cllocationManager.startMonitoringSignificantLocationChanges()
		} else {
			cllocationManager.startUpdatingLocation()
		}
	}
	
	func stopLocationUpdates() {
		if shouldMonitorSignificantChanges {
			cllocationManager.stopMonitoringSignificantLocationChanges()
		} else {
			cllocationManager.stopUpdatingLocation()
		}
	}
	
	func startFetchingLocation() {
		let authStatus = CLLocationManager.authorizationStatus()
		switch authStatus {
		case .notDetermined:
			askForPermission()
		case .restricted, .denied:
			handleLocationFetchFailure()
		case .authorizedWhenInUse, .authorizedAlways:
			startLocationUpdates()
		}
	}
	
	func askForPermission() {
		if needBackgroundPermission {
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
		if let location = locations.first, location.timestamp.without([.second]) >= Date().without([.second]) {
			let status = CLLocationManager.authorizationStatus()
			let data = LocationService.Data(location: location, status: status)
			locationHandler?(data)
			
			if !needContinousUpdates {
				stopLocationUpdates()
				locationHandler = nil
			}
		}
	}
	
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedAlways || status == .authorizedWhenInUse {
			startLocationUpdates()
		} else {
			stopLocationUpdates()
		}
	}
	
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		handleLocationFetchFailure()
	}
}

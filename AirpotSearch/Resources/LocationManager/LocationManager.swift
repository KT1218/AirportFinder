//
//  LocationManager.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
import CoreLocation
/// Clase que maneja la configuracion de la Localización.
class LocationManager: NSObject, CLLocationManagerDelegate {
    /// Instancia de CLLocationManager para manejar la ubicación.
    private let locationManager = CLLocationManager()
    /// Variable que almacena la ultima ubicación conocida,
    var lastLocation: CLLocation?
    override init() {
        super.init()
        locationManager.delegate = self 
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    /// Método para solicitar permiso de ubicación al usuario.
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    /// Método para iniciar la actualización de la ubicación.
    func startUpdatingLocation() { 
        locationManager.startUpdatingLocation()
    }
    /// Método para detener la actualización de la ubicación.
    func stopUpdatingLocation() { 
        locationManager.stopUpdatingLocation()
    }
    /// Método del delegado llamado cuando se actualiza la ubicación.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return } 
        lastLocation = location 
        print("Ubicación actual: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    /// Método del delegado llamado cuando falla la obtención de la ubicación.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { 
        print("Error al obtener la ubicación: \(error.localizedDescription)") }
}

//
//  AirPortMapPresenter.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
import CoreLocation
import MapKit
/// Clase encargada de la comunicación entre modulos.
class AirPortMapPresenter {
    /// Referencia al Interactor.
    var interactor: AirPortMapInteractorInputProtocol?
    /// Referencia a la Vista.
    weak private var view: AirPortMapViewProtocol?
    /// Referencia al Router.
    private let router: AirPortMapRouterProtocol?
    /// Variable que almacena el array de aeropuertos,
    var airports: [Airports]
    /// Variable que almacena el radio de busqueda en kilómetros.
    var radius: String?
    /// Inicializador del presenter.
    init(interface: AirPortMapViewProtocol,
         interactor: AirPortMapInteractorInputProtocol,
         router: AirPortMapRouterProtocol,
         airports: [Airports],
         radius: String?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.airports = airports
        self.radius = radius
    }
}
/// Extensión que implementa los metodos dentro del protocolo del presenter.
extension AirPortMapPresenter: AirPortMapPresenterProtocol {
    /// Método llamado cuando la vista del mapa carga.
    func viewDidLoad() {
        view?.showAirportsOnMap(airports)
        if let radiusStr = radius, let radiusDouble = Double(radiusStr) {
            let radiusMeters = CLLocationDistance(radiusDouble)
            view?.setMapRadius(radiusMeters)
        }
        if let region = calculateMapRegionForAirports() {
            view?.setMapRegion(region)
        }
    }
    /// Método para calcular la región del mapa que muestra todos los aeropuertos
    func calculateMapRegionForAirports() -> MKCoordinateRegion? {
        guard !airports.isEmpty else { return nil }
        var minLat = airports[0].latitude
        var maxLat = airports[0].latitude
        var minLon = airports[0].longitude
        var maxLon = airports[0].longitude
        for airport in airports {
            if airport.latitude < minLat {
                minLat = airport.latitude
            }
            if airport.latitude > maxLat {
                maxLat = airport.latitude
            }
            if airport.longitude < minLon {
                minLon = airport.longitude
            }
            if airport.longitude > maxLon {
                maxLon = airport.longitude
            }
        }
        let centerLat = (minLat + maxLat) / 2.0
        let centerLon = (minLon + maxLon) / 2.0
        let spanLat = (maxLat - minLat) * 1.1
        let spanLon = (maxLon - minLon) * 1.1
        let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon)
        let span = MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLon)
        let region = MKCoordinateRegion(center: center, span: span)
        return region
    }
}
/// Extension que maneja la comunicación entre el presenter y el interactor.
extension AirPortMapPresenter: AirPortMapInteractorOutputProtocol {}

//
//  AirPortFinderPresenter.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
import CoreLocation
/// Clase encargada de la comunicación entre modulos.
class AirPortFinderPresenter {
    /// Referencia al Interactor.
    var interactor: AirPortFinderInteractorInputProtocol?
    /// Referencia al Location Manager.
    var locationManager: LocationManager = LocationManager()
    /// Referencia a la Vista.
    weak private var view: AirPortFinderViewProtocol?
    /// Referencia al Router.
    private let router: AirPortFinderRouterProtocol?
    /// Variable que almacena el radio de busqueda en kilómetros.
    private var radius: String?
    /// Inicializador del presenter.
    init(interface: AirPortFinderViewProtocol, interactor: AirPortFinderInteractorInputProtocol, router: AirPortFinderRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}
/// Extensión que implementa los metodos dentro del protocolo del presenter.
extension AirPortFinderPresenter: AirPortFinderPresenterProtocol {
    /// Función que se encarga de hacer la solicitud para obtener la ubicación actual al locationManager.
    func getLocations() {
        locationManager.requestLocationPermission()
        locationManager.startUpdatingLocation()
    }
    /// Función que navega a la pantalla del mapa del aeropuerto.
    func navigateToAirPortMap(kilometers: String?) {
        self.radius = kilometers
        if let coordinate: CLLocationCoordinate2D = locationManager.lastLocation?.coordinate {
            locationManager.stopUpdatingLocation()
            interactor?.getAirports(kilometers: kilometers ?? "",
                                    latidude: coordinate.latitude.description,
                                    longitude: coordinate.longitude.description)
        }
    }
}
/// Extension que maneja la comunicación entre el presenter y el interactor.
extension AirPortFinderPresenter: AirPortFinderInteractorOutputProtocol {
    /// Función que muestra un error de solicitud incorrecta en la vista.
    func showBadRequestError() {
        view?.showBadRequestError()
    }
    /// Función que muestra un error general en la vista.
    func showError() {
        view?.showError()
    }
    /// Función que navega a la pantalla del mapa del aeropuerto con los datos de aeropuertos obtenidos.
    func bringAirports(data: [Airports]) {
        router?.navigateToAirPortMap(airports: data, radius: self.radius)
    }
}


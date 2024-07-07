//
//  AirPortMapProtocols.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
import CoreLocation
import MapKit
/// Protocolo de comunicacion entre el Presenter y la Vista.
protocol AirPortMapViewProtocol: AnyObject {
    /// Referencia al Presenter
    var presenter: AirPortMapPresenterProtocol? { get set }
    /// Método para mostrar los aeropuertos en el mapa.
    func showAirportsOnMap(_ airports: [Airports])
    /// Método para establecer el radio del mapa.
    func setMapRadius(_ radius: CLLocationDistance)
    /// Método para establecer la región del mapa.
    func setMapRegion(_ region: MKCoordinateRegion)
}
/// Protocolo de comunicacion entre el Presenter y el Interactor.
protocol AirPortMapInteractorInputProtocol: AnyObject {
    /// Referencia al Interactor.
    var presenter: AirPortMapInteractorOutputProtocol? { get set }
}
/// Protocolo de comunicacion entre el Interactor y el Presenter.
protocol AirPortMapInteractorOutputProtocol: AnyObject {}
/// Protocolo de comunicacion entre la Vista y el Presenter.
protocol AirPortMapPresenterProtocol: AnyObject {
    /// Referencia al Interactor.
    var interactor: AirPortMapInteractorInputProtocol? { get set }
    /// Arreglo que almacena los aeropuertos.
    var airports: [Airports] { get set }
    /// Método llamado cuando la vista del mapa carga.
    func viewDidLoad()
}
/// Protocolo de comunicacion entre el Presenter y el Router.
protocol AirPortMapRouterProtocol: AnyObject {}

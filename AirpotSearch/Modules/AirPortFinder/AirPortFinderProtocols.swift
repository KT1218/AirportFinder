//
//  AirPortFinderProtocols.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
/// Protocolo de comunicacion entre el Presenter y la Vista.
protocol AirPortFinderViewProtocol: AnyObject {
    /// Referencia al Presenter
    var presenter: AirPortFinderPresenterProtocol? { get set }
    /// Función que contiene el error de la respuesta del servicio.
    func showBadRequestError()
    /// Función que contiene el error del consumo del servicio.
    func showError()
}
/// Protocolo de comunicacion entre el Presenter y el Interactor.
protocol AirPortFinderInteractorInputProtocol: AnyObject {
    /// Referencia al Interactor.
    var presenter: AirPortFinderInteractorOutputProtocol? { get set }
    /// Función que comunica con el interactor para el consumo del servicio,
    func getAirports(kilometers: String, latidude: String, longitude: String)
}
/// Protocolo de comunicacion entre el Interactor y el Presenter. 
protocol AirPortFinderInteractorOutputProtocol: AnyObject {
    /// Función que contiene el error del consumo del servicio.
    func showError()
    /// Función que contiene el array de aeropuertos obtenidos por el servicio,
    func bringAirports(data: [Airports])
    /// Función que contiene el error de la respuesta del servicio.
    func showBadRequestError()
}
/// Protocolo de comunicacion entre la Vista y el Presenter.
protocol AirPortFinderPresenterProtocol: AnyObject {
    /// Referencia al Interactor.
    var interactor: AirPortFinderInteractorInputProtocol? { get set }
    /// Referencia al Location Manager.
    var locationManager: LocationManager { get set }
    /// Función encargada de la navegacion hacia el modulo AirPortMap.
    func navigateToAirPortMap(kilometers: String?)
    /// Función que inicia el Location Manager para la obtención de la ubicación.
    func getLocations()
}
/// Protocolo de comunicacion entre el Presenter y el Router.
protocol AirPortFinderRouterProtocol: AnyObject {
    /// Función encargada de la navegacion hacia el modulo AirPortMap.
    func navigateToAirPortMap(airports: [Airports], radius: String?)
}

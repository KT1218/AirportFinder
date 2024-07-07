//
//  AirPortTableProtocols.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
/// Protocolo de comunicacion entre el Presenter y la Vista.
protocol AirPortTableViewProtocol: AnyObject {
    /// Referencia al Presenter
    var presenter: AirPortTablePresenterProtocol? { get set }
    /// Función que muestra la lista de aeropuertos en la vista.
    func showAirports(_ airports: [Airports])
}
/// Protocolo de comunicacion entre el Presenter y el Interactor.
protocol AirPortTableInteractorInputProtocol: AnyObject {
    /// Referencia al Interactor.
    var presenter: AirPortTableInteractorOutputProtocol? { get set }
}
/// Protocolo de comunicacion entre el Interactor y el Presenter.
protocol AirPortTableInteractorOutputProtocol: AnyObject {}
/// Protocolo de comunicacion entre la Vista y el Presenter.
protocol AirPortTablePresenterProtocol: AnyObject {
    /// Referencia al Interactor.
    var interactor: AirPortTableInteractorInputProtocol? { get set }
    /// Arreglo que almacena los aeropuertos.
    var airports: [Airports] { get set }
    /// Método llamado cuando la vista de la tabla de aeropuertos carga.
    func viewDidLoad()
}
/// Protocolo de comunicacion entre el Presenter y el Router.
protocol AirPortTableRouterProtocol: AnyObject {}

//
//  AirPortTablePresenter.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
/// Clase encargada de la comunicación entre modulos.
class AirPortTablePresenter {
    /// Referencia al Interactor.
    var interactor: AirPortTableInteractorInputProtocol?
    /// Referencia a la Vista.
    weak private var view: AirPortTableViewProtocol?
    /// Referencia al Router.
    private let router: AirPortTableRouterProtocol?
    /// Variable que almacena el array de aeropuertos.
    var airports: [Airports]
    /// Inicializador del presenter.
    init(interface: AirPortTableViewProtocol,
         interactor: AirPortTableInteractorInputProtocol,
         router: AirPortTableRouterProtocol,
         airports: [Airports]) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.airports = airports
    }
}
/// Extensión que implementa los metodos dentro del protocolo del presenter.
extension AirPortTablePresenter: AirPortTablePresenterProtocol {
    /// Método llamado cuando la vista del mapa carga.
    func viewDidLoad() {
        view?.showAirports(airports)
    }
}
/// Extension que maneja la comunicación entre el presenter y el interactor.
extension AirPortTablePresenter: AirPortTableInteractorOutputProtocol {}


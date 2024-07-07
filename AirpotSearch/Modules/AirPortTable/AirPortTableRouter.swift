//
//  AirPortTableRouter.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
/// Clase que maneja la navegación y creacion del modúlo.
class AirPortTableRouter {
    /// Referencia a la vista.
    weak var viewController: UIViewController?
    /// Funcion que crea el modulo.
    static func createModule(airports: [Airports]) -> UIViewController? {
        let view = AirPortTableViewController(nibName: "AirPortTableViewController", bundle: nil)
        let interactor = AirPortTableInteractor()
        let router = AirPortTableRouter()
        let presenter = AirPortTablePresenter(interface: view, interactor: interactor, router: router, airports: airports)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
/// Extension que maneja la comunicacion con el Presenter.
extension AirPortTableRouter: AirPortTableRouterProtocol {}

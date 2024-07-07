//
//  AirPortMapRouter.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
/// Clase que maneja la navegación y creacion del modúlo.
class AirPortMapRouter {
    /// Referencia a la vista.
    weak var viewController: UIViewController?
    /// Funcion que crea el modulo.
    static func createModule(airports: [Airports], radius: String?) -> UIViewController? {
        let view = AirPortMapViewController(nibName: "AirPortMapViewController", bundle: nil)
        let interactor = AirPortMapInteractor()
        let router = AirPortMapRouter()
        let presenter = AirPortMapPresenter(interface: view, interactor: interactor, router: router, airports: airports, radius: radius)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
/// Extension que maneja la comunicacion con el Presenter.
extension AirPortMapRouter: AirPortMapRouterProtocol {}

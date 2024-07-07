//
//  AirPortFinderRouter.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
/// Clase que maneja la navegación y creacion del modúlo.
class AirPortFinderRouter {
    /// Referencia a la vista.
    weak var viewController: UIViewController?
    /// Funcion que crea el modulo.
    static func createModule() -> UIViewController? {
        let view = AirPortFinderViewController(nibName: "AirPortFinderViewController", bundle: nil)
        let interactor = AirPortFinderInteractor()
        let router = AirPortFinderRouter()
        let presenter = AirPortFinderPresenter(interface: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view 
        return view
    }
}
/// Extension que maneja la comunicacion con el Presenter.
extension AirPortFinderRouter: AirPortFinderRouterProtocol {
    /// Función que maneja la navegación hacia el Tab Bar.
    func navigateToAirPortMap(airports: [Airports], radius: String?) {
        guard let viewController = viewController else { return }
        DispatchQueue.main.async {
            let airPortMapViewController = AirPortTabBar()
            airPortMapViewController.airports = airports
            airPortMapViewController.radius = radius
            airPortMapViewController.configureTabBar()
            viewController.view.window?.rootViewController = airPortMapViewController
        }
    }
}

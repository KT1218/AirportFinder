//
//  AirPortTabBar.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
/// Clase encargada de la configuración del Tab Bar.
class AirPortTabBar: UITabBarController {
    /// Variable que contiene un arreglo de aeropuertos.
    var airports: [Airports] = []
    /// Variable que contiene el radio.
    var radius: String?
    /// Método para configurar el Tab Bar,
    func configureTabBar() {
        if let vcMapAirports = AirPortMapRouter.createModule(airports: airports, radius: radius),
           let vcTableAirports = AirPortTableRouter.createModule(airports: airports) {
            vcMapAirports.tabBarItem.image = UIImage(systemName: "map.fill")
            vcTableAirports.tabBarItem.image = UIImage(systemName: "table.fill")
            let navigationMap = UINavigationController(rootViewController: vcMapAirports)
            let navigationTable = UINavigationController(rootViewController: vcTableAirports)
            let lightApparence = UITabBarAppearance()
            lightApparence.configureWithOpaqueBackground()
            lightApparence.backgroundColor = .white
            lightApparence.stackedLayoutAppearance.selected.iconColor = .black
            lightApparence.stackedLayoutAppearance.normal.iconColor = .gray
            let darkApparence = UITabBarAppearance()
            darkApparence.configureWithOpaqueBackground()
            darkApparence.backgroundColor = .gray
            darkApparence.stackedLayoutAppearance.selected.iconColor = .white
            darkApparence.stackedLayoutAppearance.normal.iconColor = .lightGray
            tabBar.tintColor = .label
            tabBar.standardAppearance = lightApparence
            tabBar.scrollEdgeAppearance = lightApparence
            if #available(iOS 15.0, *) {
                tabBar.standardAppearance = UITraitCollection.current.userInterfaceStyle == .dark ? darkApparence : lightApparence
                tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            }
            setViewControllers([navigationMap, navigationTable], animated: true)
        }
    }
}

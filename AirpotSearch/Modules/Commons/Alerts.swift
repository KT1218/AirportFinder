//
//  Alerts.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 07/07/24.
//

import UIKit
/// Extensión para el manejo de las alertas.
extension UIViewController {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

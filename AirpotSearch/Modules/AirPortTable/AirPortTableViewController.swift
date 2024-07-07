//
//  AirPortTableViewController.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
/// Clase que gestiona la vista de la tabla de aeropuertos.
class AirPortTableViewController: UIViewController {
    /// Referencia a la tabla que muestra la lista de aeropuertos.
    @IBOutlet weak var tableAirports: UITableView!
    /// Objeto tipo **AirPortTablePresenterProtocol** para la comunicación con el presenter.
    var presenter: AirPortTablePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        presenter?.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    /// Función que configura la tabla de aeropuertos estableciendo delegados y registro de celdas.
    func setUpTable() {
        tableAirports.delegate = self
        tableAirports.dataSource = self
        let nib = UINib(nibName: "AirPortTableViewCell", bundle: nil)
        tableAirports.register(nib, forCellReuseIdentifier: "AirPortTableViewCell")
    }
}
/// Extensión que implementa métodos de la vista de la tabla de aeropuertos.
extension AirPortTableViewController: AirPortTableViewProtocol {
    func showAirports(_ airports: [Airports]) {
        presenter?.airports = airports
        tableAirports.reloadData()
    }
}
/// Extensión que implementa los métodos del delegado y fuente de datos de la tabla.
extension AirPortTableViewController: UITableViewDelegate, UITableViewDataSource {
    /// Función que devuelve el número de filas en la sección de la tabla.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.airports.count ?? 0
    }
    /// Función que configura y devuelve una celda para mostrar en una fila específica de la tabla.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirPortTableViewCell", for: indexPath) as! AirPortTableViewCell
        if let airport = presenter?.airports[indexPath.row] {
            cell.lblName.text = airport.name
            cell.lblIATACode.text = "IATA Code: \(airport.iataCode ?? "")"
            cell.lblICAOCode.text = "ICAO Code: \(airport.icaoCode ?? "")"
        }
        return cell
    }
    /// Función que devuelve la altura de una fila específica en la tabla.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

//
//  AirPortTableViewCell.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
/// Celda personalizada para mostrar información de un aeropuerto.
class AirPortTableViewCell: UITableViewCell {
    /// Label que muestra el nombre del aeropuerto.
    @IBOutlet weak var lblName: UILabel!
    /// Label que muestra el código IATA del aeropuerto.
    @IBOutlet weak var lblIATACode: UILabel!
    /// Label que muestra el código ICAO del aeropuerto.
    @IBOutlet weak var lblICAOCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//
//  AirPortFinderEntity.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
/// Estructura que contiene el modelo que traerá el servicio.
struct Airports: Codable {
    var iataCode: String?
    var icaoCode: String?
    var name: String?
    var alpha2countryCode: String?
    var latitude: Double
    var longitude: Double
}

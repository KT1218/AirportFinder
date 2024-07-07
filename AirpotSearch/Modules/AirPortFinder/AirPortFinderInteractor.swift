//
//  AirPortFinderInteractor.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import Foundation
import CoreLocation
/// Clase encargada del consumo del servicio.
class AirPortFinderInteractor: AirPortFinderInteractorInputProtocol {
    /// Referencia al presenter.
    weak var presenter: AirPortFinderInteractorOutputProtocol?
    /// Método para obtener aeropuertos basado en coordenadas y radio de búsqueda.
    func getAirports(kilometers: String, latidude: String, longitude: String) {
        /// URL con los parámetros de búsqueda.
        let urlString: String = "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(latidude)&lon=\(longitude)&radius=\(kilometers)"
        /// Variable con la clave de API requerida para el servicio.
        var request: URLRequest = URLRequest(url: URL(string: urlString)!)
        request.addValue("73762d4ef3msh5e3536fb99c9282p1d7c4djsncef707833f32", forHTTPHeaderField: "x-rapidapi-key")
        /// Solicitud  HTTP usando URLSession.
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if error == nil {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode {
                case 200:
                    /// Si la solicitud es exitosa (código de estado 200), se procesan los datos recibidos.
                    if let safeData = data {
                        /// Conversión los datos recibidos a formato de cadena para depuración.
                        if let jsonString: String = String(data: safeData, encoding: String.Encoding.utf8) {
                            print("🚀JSON getAirports ->:\n\(jsonString)")
                        }
                        /// Intento de decodificación de los datos JSON en un arreglo de objetos `Airports`.
                        do {
                            let model = try JSONDecoder().decode([Airports].self, from: safeData)
                            /// Si la decodificación es exitosa, los datos se envian al presenter para su manejo.
                            self?.presenter?.bringAirports(data: model)
                        } catch {
                            /// Si hay un error en la decodificación, se notifica al presenter.
                            self?.presenter?.showError()
                        }
                    }
                case 400:
                    /// Si la solicitud es incorrecta (código de estado 400), se envia el error de solicitud al presenter.
                    self?.presenter?.showBadRequestError()
                default: break
                }
            } else {
                /// Si hay un error en la conexión o la solicitud, muestra el error general.
                self?.presenter?.showError()
            }
        }.resume() /// Inicia la tarea URLSession.
    }
}


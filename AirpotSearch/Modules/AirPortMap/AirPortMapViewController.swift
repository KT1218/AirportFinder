//
//  AirPortMapViewController.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
import MapKit
/// Clase que contiene la configuración de la vista.
class AirPortMapViewController: UIViewController {
    /// Contenedor del mapa.
    @IBOutlet weak var mapContainer: MKMapView!
    /// Objeto tipo **AirPortMapPresenterProtocol** para la comunicación con el presenter.
    var presenter: AirPortMapPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapContainer.delegate = self
        mapContainer.showsUserLocation = true
        presenter?.viewDidLoad()
    }
}
/// Extension que implementa metodos para la personalización de los pin en el mapa.
extension AirPortMapViewController: MKMapViewDelegate {
    /// Método que devuelve una vista personalizada para cada anotación en el mapa.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let reuseIdentifier = "customAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
            if let image = UIImage(named: "imgPinMap")?.withRenderingMode(.alwaysOriginal) {
                annotationView?.image = image
                let size = CGSize(width: 60, height: 40)
                annotationView?.frame.size = size
                annotationView?.contentMode = .scaleAspectFit
                annotationView?.centerOffset = CGPoint(x: 0, y: -size.height / 2)
            } else {
                print("Error: No se pudo cargar la imagen customPinImage")
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            }
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
/// Extensión para la comunicación con el presenter.
extension AirPortMapViewController: AirPortMapViewProtocol {
    /// Función que muestra los aeropuertos en el mapa eliminando las anotaciones existentes.
    func showAirportsOnMap(_ airports: [Airports]) {
        mapContainer.removeAnnotations(mapContainer.annotations)
        for airport in airports {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)
            annotation.title = airport.name
            mapContainer.addAnnotation(annotation)
        }
    }
    /// Establece el radio de visualización del mapa.
    func setMapRadius(_ radius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: mapContainer.centerCoordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapContainer.setRegion(region, animated: true)
    }
    /// Establece la región visible del mapa.
    func setMapRegion(_ region: MKCoordinateRegion) {
        mapContainer.setRegion(region, animated: true)
    }
}

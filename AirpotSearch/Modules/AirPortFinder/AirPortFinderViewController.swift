//
//  AirPortFinderViewController.swift
//  AirpotSearch
//
//  Created by Ana Karen Tadeo Vicente on 06/07/24.
//
import UIKit
import AVKit
import AVFoundation
/// Clase que contiene la configuración de la vista.
class AirPortFinderViewController: UIViewController {
    /// Vista que contendra en video.
    @IBOutlet weak var viewContainerVideo: UIView!
    /// Label con el titulo de la vista,
    @IBOutlet weak var lblTitle: UILabel!
    /// Label con el subtitulo de la vista.
    @IBOutlet weak var lblSubtitle: UILabel!
    /// Label con el contador del slider.
    @IBOutlet weak var lblCount: UILabel!
    /// Slider que configurara el radio de busqueda,
    @IBOutlet weak var sliderBar: UISlider!
    /// Boton de inicio de busqueda,
    @IBOutlet weak var btnStartSearch: UIButton!
    /// Activity que marcará el inicio y final del consumo del servicio.
    @IBOutlet weak var activity: UIActivityIndicatorView!
    /// Objeto tipo **AirPortFinderPresenterProtocol** para la comunicación con el presenter,
    var presenter: AirPortFinderPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getLocations()
        setupVideoPlayer()
    }
    /// Función para la configuración del reproductor de video.
    private func setupVideoPlayer() {
        hiddenUI(isHidden: true)
        if let videoPath = Bundle.main.path(forResource: "Intro", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: videoPath)
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.view.frame = viewContainerVideo.bounds
            playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            playerViewController.showsPlaybackControls = false
            player.isMuted = true
            addChild(playerViewController)
            viewContainerVideo.addSubview(playerViewController.view)
            playerViewController.didMove(toParent: self)
            player.play()
            NotificationCenter.default.addObserver(self, selector: #selector(restartVideo), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            hiddenUI(isHidden: false)
        } else {
            print("No se pudo encontrar el video")
            hiddenUI(isHidden: false)
        }
    }
    /// Función para ocultar o mostrar elementos de UI y controlar la actividad.
    func hiddenUI(isHidden: Bool) {
        lblCount.isHidden = isHidden
        sliderBar.isHidden = isHidden
        btnStartSearch.isHidden = isHidden
        self.view.alpha = 1.0
        activity.stopAnimating()
        btnStartSearch.isEnabled = true
        sliderBar.isEnabled = true
    }
    /// Método para reiniciar el video cuando finaliza la reproducción.
    @objc private func restartVideo() {
        if let player = (self.children.compactMap { $0 as? AVPlayerViewController }.first?.player) {
            player.seek(to: .zero)
            player.play()
        }
    }
    /// Método llamado cuando se presiona el botón de búsqueda.
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.view.alpha = 0.5
        activity.startAnimating()
        btnStartSearch.isEnabled = false
        sliderBar.isEnabled = false
        presenter?.navigateToAirPortMap(kilometers: lblCount.text)
    }
    /// Alerta que se muestra cuando el usuario no selecciono un radio valido.
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    /// Método llamado cuando se cambia el valor del slider.
    @IBAction func sliderValueChange(_ sender: Any) {
        let slider = sender as! UISlider
        let value = Int(round(slider.value))
        lblCount.text = String(value)
    }
}
/// Extensión para la comunicación con el presenter.
extension AirPortFinderViewController: AirPortFinderViewProtocol {
    /// Función que muestra una alerta cuando ocurre un error de solicitud incorrecta.
    func showBadRequestError() {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: "Error", message: "Bad request. Please check your input.")
        }
    }
    /// Función que muestra una alerta cuando ocurre un error general.
    func showError() {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: "Error", message: "An error occurred. Please try again later.")
        }
    }
}

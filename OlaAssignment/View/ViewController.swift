//
//  ViewController.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    //MARK:- Constant
    struct Constants {
        static let cancel = "Cancel"
        static let blank = ""
        static let cellIdentifier = "cabInfoCollectionViewCell"
        static let annotationImageHeight = 20.0
        static let annotationImagewidth = 20.0
    }
    
    //MARK:- Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var carInfoList: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var mapInformation: [MapDetailsModel]?
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCollectionCell()
        self.loadDetails()
    }
    
    func loadDetails() {
        // get Data from service
        let mapVModel = MapDetailsViewModel(mapInfo: nil, mapDelegate: self)
        mapVModel.fetchMapDetails()
    }
    
    func startLoadingIndicator() {
        // start activity spinner
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func updateTableView() {
        self.activityIndicator.stopAnimating()
        self.carInfoList.isHidden = false
        self.carInfoList.reloadData()
    }
    //MARK:- Register cell
    func registerCollectionCell() {
        self.carInfoList.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    //MARK:- Locate on Map
    func setLocationsOnMap() {
        // Show position on maps
        guard let details = self.mapInformation else {
            return
        }
        let initialLocation = CLLocation(latitude: details.first?.location?.latitude ?? 0.0, longitude: details.first?.location?.longitude ?? 0.0)
        self.centerMapOnLocation(location: initialLocation)
        
        // add all locations on map
        for carDetail in details {
            if let carName = carDetail.vehicleDetails?.name,
                let carType = carDetail.vehicleDetails?.make,
                let imageUrl = carDetail.carImageUrl,
                let carLocation = carDetail.location  {
                let artwork = MapDetailsAnnotation(title: carName,
                                                   carType: carType,
                                                   imageName: imageUrl,
                                                   coordinate: CLLocationCoordinate2D(latitude: carLocation.latitude ?? 0.0, longitude: carLocation.longitude ?? 0.0))
                mapView.addAnnotation(artwork)
            }
        }
    }
}

extension ViewController: MapInformationProtocol {
    func updateMapDetails(mapDetails: Any?, error: Error?) {

        if error == nil {
            guard let response = mapDetails as? [MapDetailsModel] else {
                    return
            }
            
            self.mapInformation = response
            DispatchQueue.main.async{
                self.updateTableView()
                self.setLocationsOnMap()
            }
        } else if let erorrDiscription = error {
            DispatchQueue.main.async {
                self.updateTableView()
                let alertViewController = UIAlertController(title: Constants.blank, message: erorrDiscription.localizedDescription, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
}

//MARK: CollectionView Datasource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mapInformation?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath as IndexPath) as? cabInfoCollectionViewCell,
            let details = self.mapInformation else {
                return UICollectionViewCell()
        }
        cell.configureCell(details: details[indexPath.row])
        return cell
    }
}

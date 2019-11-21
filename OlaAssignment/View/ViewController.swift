//
//  ViewController.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Constant
    struct Constants {
        static let cancel = "Cancel"
        static let blank = ""
        static let cellIdentifier = "CabInfoCell"
    }
    
    //MARK:- Properties
    
    @IBOutlet weak var carInfoList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var mapInformation: [MapDetailsModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNewsCell()
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
    func registerNewsCell() {
        self.carInfoList.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
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

//MARK: Table Datasource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mapInformation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? CabInfoCell,
            let details = self.mapInformation else {
                return UITableViewCell()
        }
        
        cell.configureCell(details: details[indexPath.row])
        return cell
    }
}

//MARK: Table Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = mapInformation else {
            return
        }
        
    }
}

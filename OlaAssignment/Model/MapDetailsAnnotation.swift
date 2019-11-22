//
//  MapDetailsAnnotation.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 22/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation
import MapKit

class MapDetailsAnnotation: NSObject, MKAnnotation {
    let title: String?
    let carType: String
    let imageName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, carType: String, imageName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.carType = carType
        self.imageName = imageName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return carType
    }
}

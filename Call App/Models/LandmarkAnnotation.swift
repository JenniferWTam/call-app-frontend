//
//  LandmarkAnnotation.swift
//  Call App
//
//  Created by Jennifer Tam on 8/7/23.
//

import Foundation
import MapKit
import UIKit


final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}

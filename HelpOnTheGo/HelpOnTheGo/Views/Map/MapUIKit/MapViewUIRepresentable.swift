//
//  MapViewUIRepresentable.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-18.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

struct MapKitUIViewRepresentable: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    @Binding var annotations: [MKPointAnnotation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator

        return mapView
    }

    // Update UI When map changes ?
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
        //uiView.region.span = MKCoordinateSpan(latitudeDelta: 1000, longitudeDelta: 1000)
        print("ANnotations: \(annotations)")
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapKitUIViewRepresentable
        
        init(parent: MapKitUIViewRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "pin"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) 
            
            if annotationView == nil {
//                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView?.canShowCallout = true
//                annotationView?.tintColor = .red
//                annotationView?.image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            } else {
                annotationView?.annotation = annotation
                annotationView?.tintColor = .red
                annotationView?.image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            }
            
            return annotationView
        }
    }
}

//
//  FindNearestView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-18.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI
import MapKit

struct FindNearestView: UIViewRepresentable {

  var locationManager = CLLocationManager()
  var mapView = MKMapView(frame: UIScreen.main.bounds)
  
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }

  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    self.mapView.showsUserLocation = true
    self.mapView.userTrackingMode = .follow
    return self.mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    self.searchForGroceryStores()
  }
  
  func searchForGroceryStores() {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = "Grocery Stores"
    let search = MKLocalSearch(request: searchRequest)
    searchRequest.region = self.mapView.region
    search.start { response, error in
      guard let response = response else {
          print("Error: \(error?.localizedDescription ?? "Unknown error").")
          return
      }
      for item in response.mapItems {
        let location =  MKPointAnnotation()
        location.title = item.placemark.name
        location.coordinate = item.placemark.coordinate
        self.mapView.addAnnotation(location)
        print(item.placemark.name)
      }
      print("-------------")
    }
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      guard annotation is MKPointAnnotation else { return nil }

      let identifier = "Annotation"
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

      if annotationView == nil {
          annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          annotationView!.canShowCallout = true
      } else {
          annotationView!.annotation = annotation
      }

      return annotationView
  }
}

struct FindNearestView_Previews: PreviewProvider {
    static var previews: some View {
        FindNearestView()
    }
}

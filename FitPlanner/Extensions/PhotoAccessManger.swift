//
//  PhotoAccessManger.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 5/25/22.
//

import Foundation
import PhotosUI

// MARK: - PhotoAccessManagerDelegate
protocol PhotoAccessManagerDelegate {
    func showFullAccessUI()
    func showLimittedAccessUI()
    func showRestrictedAccessUI()
    func showAccessDeniedUI()
}


// MARK: - PhotoAccessManger
class PhotoAccessManger {
    
    public var delegate: PhotoAccessManagerDelegate?
    
    public func setupPhotoAccess() {
        // Request permission to access photo library
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                showUI(for: status)
            }
        }
    }
    
    private func showUI(for status: PHAuthorizationStatus) {
                
        switch status {
        case .authorized:
            showFullAccessUI()

        case .limited:
            showLimittedAccessUI()

        case .restricted:
            showRestrictedAccessUI()

        case .denied:
            showAccessDeniedUI()

        case .notDetermined:
            break

        @unknown default:
            break
        }
    }
    
    private func showFullAccessUI() {
        print("full access")
        let photoCount = PHAsset.fetchAssets(with: nil).count
        print("Photo count:", photoCount)
        
        delegate?.showFullAccessUI()
    }
    
    private func showLimittedAccessUI() {
        print("limited access")
        let photoCount = PHAsset.fetchAssets(with: nil).count
        print("Photo count:", photoCount)
        
        delegate?.showLimittedAccessUI()
    }
    
    private func showRestrictedAccessUI() {
        print("Restricted access")
        
        delegate?.showRestrictedAccessUI()
    }
    
    private func showAccessDeniedUI() {
        print("access denied")
        
        delegate?.showAccessDeniedUI()
    }
    
    /*
     "Select Photos" -> limited access -> authorized
     "Allow access to all photos" -> full access -> authorized
     "Dont't allow" -> access denied -> denied
    */
    
}

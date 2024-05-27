//
//  PetViewModel.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import Foundation
import UIKit

// MARK: - Event Enum

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}

class PetViewModel {
    
    // MARK: - Properties
    
    var petsData: [PetModel] = []
    var settings: Settings?
    var eventHandler: ((_ event: Event) -> Void)?
    
    // MARK: - Fetch Methods
    
    func fetchPetsData() {
        guard let url = URL(string: APIURL.baseURLPets) else {
            return
        }
        
        APIManager.shared.fetch(petFrom: url) { (result: Result<DataModel, DataError>) in
            
            switch result {
            case .success(let petData):
                self.petsData = petData.pets ?? []
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func fetchConfigData() {
        guard let configUrl = URL(string: APIURL.baseURLConfig) else {
            return
        }
        
        APIManager.shared.fetch(petFrom: configUrl) { (result: Result<ResponseData, DataError>) in

            switch result {
            case .success(let responseData):
                self.settings = responseData.settings
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

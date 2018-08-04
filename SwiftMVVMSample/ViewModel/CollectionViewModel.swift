//
//  CollectionViewModel.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

class CollectionViewModel {
    
    var service: NetworkRepository
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var photos: Dynamic<MusicVideoList> = Dynamic(MusicVideoList())
    var hasError: Dynamic<Bool> = Dynamic(false)
    
    init(service: NetworkRepository) {
        self.service = service
    }
    
    func getData() {
        isLoading.value = true
        
        service.getMusicVideoList { (ResponeStatus) in
            
            self.isLoading.value = false
            
            switch ResponeStatus {
            case .success(let data):
                self.hasError.value = false
                self.photos.value = data
                break
            case .failure(let errorType, let message):
                self.hasError.value = true
                print("\(errorType) ,  \(message)")
                break
            }
        }
    }
    
    func viewModelForCell(indexPath: IndexPath) -> CollectionCellViewModel {
        let item = photos.value?.results![indexPath.row]
        let cellViewModel = CollectionCellViewModel(imagePath: item?.artworkUrl100 ?? "", trackName: item?.trackName ?? "")
        return cellViewModel
    }
    
    func numberOfSection()-> Int{
        return 1
    }
    
    func numberOfRow(in section:Int)-> Int {
        return photos.value?.results?.count ?? 0
    }
}

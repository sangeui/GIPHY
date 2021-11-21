//
//  ViewerViewModel.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation
class ViewerViewModel {
    var profileNames: (primary: String, secondary: String) {
        return (self.image.user?.primaryName ?? "", self.image.user?.secondaryName ?? "")
    }
    
    var url: URL? {
        return URL(string: self.image.original)
    }
    
    var isFavoriteContent: Bool {
        return (try? self.favorite.read(key: self.image.uniqueID)) ?? false
    }
    
    private let image: ImageProviderImage
    private let favorite: UserFavoriteUseCase = .init(storage: LocalStorage())
    
    init(image: ImageProviderImage) {
        self.image = image
    }
    
    func userDidTouchFavorite(_ favorite: Bool) {
        self.favorite.update(key: self.image.uniqueID, favorite: favorite)
    }
}

//
//  SceneDelegate.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = .init(windowScene: windowScene)
        self.window?.rootViewController = self.inject()
        self.window?.makeKeyAndVisible()
    }
}

private extension SceneDelegate {
    func inject() -> ViewController {
        let imageProvider: ImageProviderProtocol = GiphyImageProvider()
        let imageSearchUsecase: SearchImageUseCase = .init(imageProvider: imageProvider)
        let viewModel: SearchViewModel = .init(searchImage: imageSearchUsecase)
        
        return .init(viewModel: viewModel)
    }
}

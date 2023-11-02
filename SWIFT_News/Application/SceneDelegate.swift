//
//  SceneDelegate.swift
//  SWIFT_News
//
//  Created by 이윤수 on 2023/08/16.
//

import UIKit

import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let container = Container()
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        self.container.register(AppCoordinator.self) { _ in AppCoordinator(navigationController)}
        [
            DataAssembly(),
            DomainAssembly(),
            MainAssembly(),
            DetailAssembly()
        ].forEach { [weak self] value in
            let type = value as? Assembly
            type!.assemble(container: self?.container ?? Container())
        }
        
        self.appCoordinator = self.container.resolve(AppCoordinator.self)!
        self.appCoordinator.container = self.container
        self.appCoordinator.start()
    }
}

//
//  UpcomingMoviesConfigurator.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 02/01/2023.
//

final class UpcomingMoviesConfigurator {
    static func injectDependencies(for viewController: UpcomingMoviesViewController) {
        let interactor = UpcomingMoviesInteractor()
        let networkWorker = UpcomingMoviesNetworkingWorker()
        let presenter = UpcomingMoviesPresenter()
        let router = UpcomingMoviesRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.networkWorker = networkWorker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}

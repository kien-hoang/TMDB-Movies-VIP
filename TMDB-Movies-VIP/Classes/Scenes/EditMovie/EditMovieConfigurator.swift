//
//  EditMovieConfigurator.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

final class EditMovieConfigurator {
    static func injectDependencies(for viewController: EditMovieViewController) {
        let interactor = EditMovieInteractor()
        let worker = EditMovieWorker()
        let presenter = EditMoviePresenter()
        let router = EditMovieRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}

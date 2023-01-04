//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

final class ___VARIABLE_sceneName___Configurator {
    static func injectDependencies(for viewController: ___VARIABLE_sceneName___ViewController) {
        let interactor = ___VARIABLE_sceneName___Interactor()
        let worker = ___VARIABLE_sceneName___Worker()
        let presenter = ___VARIABLE_sceneName___Presenter()
        let router = ___VARIABLE_sceneName___Router()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.view = viewController
        
        router.view = viewController
        router.dataStore = interactor
    }
}

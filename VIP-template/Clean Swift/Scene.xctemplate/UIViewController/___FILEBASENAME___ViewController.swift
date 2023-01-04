//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

protocol PresenterToView___VARIABLE_sceneName___Protocol: AnyObject {}

final class ___VARIABLE_sceneName___ViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractor___VARIABLE_sceneName___Protocol?
    var router: (ViewToRouter___VARIABLE_sceneName___Protocol & DataPassing___VARIABLE_sceneName___Protocol)?
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ___VARIABLE_sceneName___Configurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ___VARIABLE_sceneName___Configurator.injectDependencies(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func applyLocalization() {}
}

// MARK: - IBAction

private extension ___VARIABLE_sceneName___ViewController {}

// MARK: - PresenterToView

extension ___VARIABLE_sceneName___ViewController: PresenterToView___VARIABLE_sceneName___Protocol {}

// MARK: - Private

private extension ___VARIABLE_sceneName___ViewController {}

//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

protocol ViewToRouter___VARIABLE_sceneName___Protocol: AnyObject {}

protocol DataPassing___VARIABLE_sceneName___Protocol {
    var dataStore: DataStore___VARIABLE_sceneName___Protocol? { get }
}

final class ___VARIABLE_sceneName___Router: DataPassing___VARIABLE_sceneName___Protocol {
    
    // MARK: - Public Variable
    
    weak var view: ___VARIABLE_sceneName___ViewController?
    var dataStore: DataStore___VARIABLE_sceneName___Protocol?
}

// MARK: - ViewToRouter

extension ___VARIABLE_sceneName___Router: ViewToRouter___VARIABLE_sceneName___Protocol {
    /*
    func navigateToSomeWhere() {
        let storyboard = UIStoryboard(name: "SomeWhere", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: SomeWhereViewController.self)) as! SomeWhereViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomeWhere(source: dataStore!, destination: &destinationDS)
        navigateToSomeWhere(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToSomeWhere(source: ___VARIABLE_sceneName___ViewController,
                             destination: SomeWhereViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToSomeWhere(source: DataStore___VARIABLE_sceneName___Protocol,
                             destination: inout SomeWhereDataStore) {
        // destination.name = source.name
    }
    */
}

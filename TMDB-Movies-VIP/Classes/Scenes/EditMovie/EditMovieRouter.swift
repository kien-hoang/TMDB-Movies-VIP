//
//  EditMovieRouter.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import UIKit

protocol ViewToRouterEditMovieProtocol: AnyObject {}

protocol DataPassingEditMovieProtocol {
    var dataStore: DataStoreEditMovieProtocol? { get }
}

final class EditMovieRouter: DataPassingEditMovieProtocol {
    
    // MARK: - Public Variable
    
    weak var view: EditMovieViewController?
    var dataStore: DataStoreEditMovieProtocol?
}

// MARK: - ViewToRouter

extension EditMovieRouter: ViewToRouterEditMovieProtocol {
    /*
    func navigateToSomeWhere() {
        let storyboard = UIStoryboard(name: "SomeWhere", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: String(describing: SomeWhereViewController.self)) as! SomeWhereViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomeWhere(source: dataStore!, destination: &destinationDS)
        navigateToSomeWhere(source: view!, destination: destinationVC)
    }
    
    // MARK: - Navigation
    
    func navigateToSomeWhere(source: EditMovieViewController,
                             destination: SomeWhereViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToSomeWhere(source: DataStoreEditMovieProtocol,
                             destination: inout SomeWhereDataStore) {
        // destination.name = source.name
    }
    */
}

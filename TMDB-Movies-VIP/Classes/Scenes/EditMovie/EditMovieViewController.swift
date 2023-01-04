//
//  EditMovieViewController.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import UIKit

protocol PresenterToViewEditMovieProtocol: AnyObject {}

final class EditMovieViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorEditMovieProtocol?
    var router: (ViewToRouterEditMovieProtocol & DataPassingEditMovieProtocol)?
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        EditMovieConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        EditMovieConfigurator.injectDependencies(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.setupMovieData()
    }
    
    override func applyLocalization() {}
}

// MARK: - IBAction

private extension EditMovieViewController {}

// MARK: - PresenterToView

extension EditMovieViewController: PresenterToViewEditMovieProtocol {}

// MARK: - Private

private extension EditMovieViewController {}

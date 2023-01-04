//
//  EditMovieViewController.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 03/01/2023.
//  
//

import UIKit

protocol PresenterToViewEditMovieProtocol: AnyObject {
    func updateUI(with viewModel: EditMovie.EditMovie.ViewModel)
    func updateMovieDataSuccess()
    
    func showMovieTitleError(_ error: String?)
    func showMovieOverviewError(_ error: String?)
    func showMoviePointAverageError(_ error: String?)
}

final class EditMovieViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var idTextField: CommonTextField!
    @IBOutlet private weak var titleTextField: CommonTextField!
    @IBOutlet private weak var overviewTextField: CommonTextField!
    @IBOutlet private weak var pointAverageTextField: CommonTextField!
    @IBOutlet private weak var updateButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var updateButton: UIButton!
    
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
        setupUI()
        addObserverKeyBoard()
        hideKeyboardWhenTappedAround(isCancelTouchInView: true)
        interactor?.getMovieData()
    }
    
    override func applyLocalization() {
        title = "Edit Movie"
        idTextField.title = "ID:"
        titleTextField.title = "Name:"
        overviewTextField.title = "Overview:"
        pointAverageTextField.title = "Point:"
        
        titleTextField.inputTextField.placeholder = "Input movie name"
        overviewTextField.inputTextField.placeholder = "Input movie overview"
        pointAverageTextField.inputTextField.placeholder = "Input movie point"
    }
    
    override func updateLayoutWhenKeyboardChanged(height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.updateButtonBottomConstraint.constant = height > 0 ? height : 4
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - IBAction

private extension EditMovieViewController {
    @IBAction func updateButtonTapped(_ sender: Any) {
        let title = titleTextField.inputTextField.text.orEmpty.asTrimmed
        let overview = overviewTextField.inputTextField.text.orEmpty.asTrimmed
        let point = pointAverageTextField.inputTextField.text.orEmpty.asTrimmed
        
        interactor?.requestUpdateMovie(EditMovie.EditMovie.Request(title: title,
                                                                   overview: overview,
                                                                   pointAverage: point))
    }
}

// MARK: - PresenterToView

extension EditMovieViewController: PresenterToViewEditMovieProtocol {
    func updateMovieDataSuccess() {
        router?.navigateBackToUpcomingMovies()
    }
    
    func showMovieTitleError(_ error: String?) {
        titleTextField.error = error
    }
    
    func showMovieOverviewError(_ error: String?) {
        overviewTextField.error = error
    }
    
    func showMoviePointAverageError(_ error: String?) {
        pointAverageTextField.error = error
    }
    
    func updateUI(with viewModel: EditMovie.EditMovie.ViewModel) {
        idTextField.inputTextField.text = viewModel.id
        titleTextField.inputTextField.text = viewModel.title
        overviewTextField.inputTextField.text = viewModel.overview
        pointAverageTextField.inputTextField.text = viewModel.pointAverage
        
        if let backdropUrl = viewModel.backdropImageUrl {
            backdropImageView.setImage(with: URL(string: backdropUrl))
        }
        if let posterUrl = viewModel.posterImageUrl {
            posterImageView.setImage(with: URL(string: posterUrl))
        }
    }
}

// MARK: - Private

private extension EditMovieViewController {
    func setupUI() {
        idTextField.isEditable = false
        titleTextField.inputTextField.delegate = self
        overviewTextField.inputTextField.delegate = self
        pointAverageTextField.inputTextField.delegate = self
        pointAverageTextField.inputTextField.keyboardType = .decimalPad
    }
}

// MARK: - UITextFieldDelegate

extension EditMovieViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case titleTextField.inputTextField:
            return interactor?.canUpdateTitleTextField(textField.text,
                                                       shouldChangeCharactersIn: range,
                                                       replacementString: string) ?? false
        case overviewTextField.inputTextField:
            return interactor?.canUpdateOverviewTextField(textField.text,
                                                          shouldChangeCharactersIn: range,
                                                          replacementString: string) ?? false
        default:
            return true
        }
    }
}

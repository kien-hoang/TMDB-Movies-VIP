//
//  UpcomingMoviesViewController.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import UIKit
import SVProgressHUD

protocol PresenterToViewUpcomingMoviesProtocol: BaseViewControllerProtocol {
    func reloadTableViewData(with getMoviesViewModel: UpcomingMovies.GetMovies.ViewModel)
}

final class UpcomingMoviesViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var submitButton: UIButton!
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorUpcomingMoviesProtocol?
    var router: (ViewToRouterUpcomingMoviesProtocol & DataPassingUpcomingMoviesProtocol)?
    
    // MARK: - Private Variable
    
    private var movies: [UpcomingMovieViewModel] = []
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        UpcomingMoviesConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UpcomingMoviesConfigurator.injectDependencies(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.viewDidLoad()
    }
    
    override func applyLocalization() {
        title = "List Error Products"
        submitButton.setTitle("SUBMIT", for: .normal)
    }
}

// MARK: - IBAction

private extension UpcomingMoviesViewController {
    @IBAction func submitButtonTapped(_ sender: Any) {
        
    }
}

// MARK: - Public

extension UpcomingMoviesViewController {
    func updateMovieSuccess() {
        interactor?.reloadTableViewData()
    }
}

// MARK: - PresenterToView

extension UpcomingMoviesViewController: PresenterToViewUpcomingMoviesProtocol {
    func reloadTableViewData(with getMoviesViewModel: UpcomingMovies.GetMovies.ViewModel) {
        self.movies = getMoviesViewModel.movies
        tableView.reloadData()
    }
}

// MARK: - Private

private extension UpcomingMoviesViewController {
    func setupUI() {
        tableView.register(UpcomingMovieCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension UpcomingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UpcomingMovieCell.self, for: indexPath)
        cell.update(with: movies[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UpcomingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToEditMovieView()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

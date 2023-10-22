//
//  CharactersViewController.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.08.2023.
//

import UIKit

final class CharactersViewController: UIViewController {
    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 156, height: 202)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(hex: Colors.background)
        collectionView.register(CharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.cellIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(hex: Colors.green)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    // MARK: - Properties

    let viewModel: CharacterViewModel

    // MARK: - Initialization

    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        configureLayout()
        configureNavigationBar()
        viewModel.delegate = self
    }

    //MARK: - Private functions

    private func configureNavigationBar() {
        title = Texts.characters
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }

    private func fetchData() {
        activityIndicatorView.startAnimating()
        viewModel.fetchCharacters()
    }

    private func configureLayout() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func showAlertError (message: String) {
        let badInternetAlert = UIAlertController(title: Titles.error,
                                                 message: message,
                                                 preferredStyle: .alert
        )
        badInternetAlert.addAction(UIAlertAction(title: Titles.ok,
                                                 style: .default,
                                                 handler: { [weak self] _ in
            guard let self else { return }
            self.fetchData()
        }))
        present(badInternetAlert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }

        let character = viewModel.characters[indexPath.item]
        cell.configureData(character)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tapOnTheCharacter(indexPath: indexPath)
    }
}

// MARK: - CharactersViewDelegate

extension CharactersViewController: CharactersViewDelegate {
    func success() {
        self.collectionView.reloadData()
        activityIndicatorView.stopAnimating()
    }

    func failure(error: NetworkError) {
        let message: String
        switch error {
        case .invalidUrl:
            message = "Invalid URL"
        case .requestError(_):
            message = "Request Error"
        case .parsingError:
            message = "Parsing Error"
        }
        showAlertError(message: message)
    }
}

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
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(named: Colors.background)
        collectionView.register(
          CharacterCollectionViewCell.self,forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        activityIndicatorView.style = .large
        activityIndicatorView.color = UIColor(named: Colors.greenText)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    var viewModel: CharacterViewModelProtocol!

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        configureLayout()
        configureNavigationBar()
    }

    //MARK: - Private

    private func configureNavigationBar() {
        title = Constants.title
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

    private func showAlertError () {
        let badInternetAlert = UIAlertController(
            title: Constants.alertTitle,
            message: Constants.alertMessage,
            preferredStyle: .alert
        )
        badInternetAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.fetchData()
        }))
        present(badInternetAlert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell,
              let character = viewModel.characters?[indexPath.item] else {
            return UICollectionViewCell()
        }

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

extension CharactersViewController: CharactersViewProtocol {
    func success() {
        self.collectionView.reloadData()
        activityIndicatorView.stopAnimating()
    }

    func failure(error: Error) {
        showAlertError()
    }
}

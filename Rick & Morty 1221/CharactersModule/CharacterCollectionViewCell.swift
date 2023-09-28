//
//  CharacterCollectionViewCell.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.08.2023.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Subviews

    private lazy var imageCharacter: WebImageView = {
        let imageView = WebImageView(frame: CGRect(x: 0, y: 0, width: 140, height: 140))
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameCharacter: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super .init(frame: frame)

        configureLayout()
        backgroundColor = UIColor(named: Colors.backgroundCell)
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureData (_ data: CharacterModel) {
        imageCharacter.set(imageURL: data.image)
        nameCharacter.text = data.name
    }

    // MARK: - Layout

    private func configureLayout() {
        addSubview(imageCharacter)
        addSubview(nameCharacter)

        NSLayoutConstraint.activate([
            imageCharacter.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageCharacter.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageCharacter.widthAnchor.constraint(equalToConstant: 140),
            imageCharacter.heightAnchor.constraint(equalToConstant: 140),

            nameCharacter.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameCharacter.heightAnchor.constraint(equalToConstant: 22),
            nameCharacter.widthAnchor.constraint(lessThanOrEqualToConstant: 140),
            nameCharacter.topAnchor.constraint(equalTo: imageCharacter.bottomAnchor, constant: 16),
        ])
    }
}

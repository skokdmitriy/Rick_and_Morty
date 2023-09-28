//
//  DetailInfoView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import SwiftUI

struct HeaderView: View {
    let characterDetailModel: CharacterDetailModel
    let viewModel: DetailViewModel

    var body: some View {
        VStack(spacing: .zero) {
            CustomImageView(urlString: characterDetailModel.image)

            Text(characterDetailModel.name)
                .foregroundColor(.white)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Text(characterDetailModel.status)
                .foregroundColor(viewModel.statusColor(for: characterDetailModel.status))
                .font(.system(size: 16))
                .fontWeight(.medium)
                .padding(.bottom, 8)
        }
    }
}

private extension HeaderView {
    struct CustomImageView: View {
        var urlString: URL
        @ObservedObject var webImageView = WebImageView()
        @State var image: UIImage = UIImage()

        var body: some View {
            Image(uiImage: image)
                .resizable()
                .frame(width: 148, height: 148)
                .cornerRadius(16)
                .padding(.bottom, 24)
                .padding(.top)
                .onReceive(webImageView.$imageSui) { image in
                    self.image = image
                }
                .onAppear{
                    webImageView.set(imageURL: urlString)
                }
        }
    }
}

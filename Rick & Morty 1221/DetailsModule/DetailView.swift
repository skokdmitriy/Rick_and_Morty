//
//  DetailView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 18.08.2023.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var viewModel: DetailViewModel

    var body: some View {
        ZStack {
            Color(Colors.background).ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(Colors.greenText)))
            } else {
                ScrollView {
                    VStack(spacing: .zero) {

                        if let detailModel = viewModel.character {
                            HeaderView(characterDetailModel: detailModel, viewModel: viewModel)
                            InfoSectionView(characterDetailModel: detailModel)
                            OriginSectionView(characterDetailModel: detailModel)
                            makeEpisodesSection()
                        }
                    }
                }
            }
        }
    }

    private func makeEpisodesSection() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(Constants.textEpisodes)
                .foregroundColor(.white)
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .frame(alignment: .topLeading)
                .padding(.bottom)
                .padding(.leading, 24)

            ForEach(viewModel.episodes, id: \.self) { episodeModel in
                EpisodeView(episodeModel: episodeModel)
            }
        }
    }
}

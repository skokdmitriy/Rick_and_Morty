//
//  EpisodesSectionView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.09.2023.
//

import SwiftUI

struct EpisodeView: View {
    let episodeModel: EpisodeModel

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(episodeModel.name)
                .foregroundColor(.white)
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .padding(.bottom)

            HStack{
                Text(episodeModel.episode)
                    .foregroundColor(Color(Colors.greenText))
                    .font(.system(size: 13))
                    .fontWeight(.medium)

                Spacer()

                Text(episodeModel.airDate)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
            }
        }
        .padding()
        .background(Color(Colors.backgroundCell))
        .cornerRadius(16)
        .padding([.leading, .trailing, .bottom], 24)
    }
}

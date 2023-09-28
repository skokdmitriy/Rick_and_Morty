//
//  OriginSectionView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.09.2023.
//

import SwiftUI

struct OriginSectionView: View {
    let characterDetailModel: CharacterDetailModel

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(Constants.textOrigin)
                .foregroundColor(.white)
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .frame(alignment: .topLeading)
                .padding(.bottom)

            HStack(spacing: .zero) {
                ZStack{
                    Image(Constants.planetIcon)
                }
                .frame(width: 64, height: 64)
                .background(Color(Colors.dark))
                .cornerRadius(10)
                .padding(.trailing, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text(characterDetailModel.origin.name)
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    Text(Constants.textPlanet)
                        .foregroundColor(Color(Colors.greenText))
                        .font(.system(size: 13))
                        .fontWeight(.medium)
                }
                Spacer()
            }
            .padding([.leading, .bottom, .top], 8)
            .background(Color(Colors.backgroundCell))
            .cornerRadius(16)
        }
        .padding([.leading, .trailing, .bottom], 24)
    }
}

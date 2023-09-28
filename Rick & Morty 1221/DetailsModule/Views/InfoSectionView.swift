//
//  InfoSectionView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.09.2023.
//

import SwiftUI

struct InfoSectionView: View {
    let characterDetailModel: CharacterDetailModel

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(Constants.textInfo)
                .foregroundColor(.white)
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .frame(alignment: .topLeading)
                .padding([.top, .bottom])

            VStack(alignment: .leading, spacing: .zero) {
                HStack{
                    Text(Constants.textSpecies)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 16))
                        .fontWeight(.medium)

                    Spacer()

                    Text(characterDetailModel.species)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                }
                .padding([.leading, .top, .trailing])

                HStack{
                    Text(Constants.textType)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 16))
                        .fontWeight(.medium)

                    Spacer()

                    Text(characterDetailModel.type == "" ? Constants.textNone : characterDetailModel.type)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                }
                .padding([.leading, .top, .trailing])

                HStack{
                    Text(Constants.textGender)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 16))
                        .fontWeight(.medium)

                    Spacer()

                    Text(characterDetailModel.gender)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                }
                .padding()
            }
            .background(Color(Colors.backgroundCell))
            .cornerRadius(16)
        }
        .padding([.leading, .trailing, .bottom], 24)
    }
}

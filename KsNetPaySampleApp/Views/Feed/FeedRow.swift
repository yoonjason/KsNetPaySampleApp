//
//  FeedRow.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import SwiftUI

struct FeedRow: View {


    var body: some View {
        GeometryReader { g in
            Rectangle().fill(Color.clear)
                .overlay(
                VStack(alignment: .leading) {
                    profileView
                    descriptionView
                    descriptionImageView
                    HStack(spacing: 5) {
                        Spacer()
                        Text("좋아요")
                        Text("10")
                        Text("댓글")
                        Text("5")
                    }
                    .font(Font.system(size: 14))
                    .foregroundColor(.gray)
                }
            )
                .padding()
                .frame(height: 400)
        }
    }

    var profileView: some View {
        HStack(spacing: 8) {
            Image("imgProfileOfficeW")
                .resizable()
                .frame(width: 42, height: 42)
            VStack(alignment: .leading) {
                Text("기묘한의 꿀팁").fontWeight(.semibold)
                Text("2020년 10월 25일 오전 10:00").font(Font.system(size: 12)).foregroundColor(.gray)
            }
        }
    }
    
    var descriptionView : some View {
        Text("피규어 수집 좋아하시는분들 안계시나요?? 나이가 먹었는데도 아직까지 원피스 웹툰이나 영화가 올라오면 항상 보러가네요 친구가 오덕 같다고해도 무시ㅋㅋㅋ 다들 한…").font(Font.system(size: 14))
            .lineLimit(3)
    }
    
    var descriptionImageView : some View {
        Image("moon")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minHeight: 247)
            .clipped()
            .cornerRadius(15)
    }
}

struct FeedRow_Previews: PreviewProvider {
    static var previews: some View {
        FeedRow()
    }
}

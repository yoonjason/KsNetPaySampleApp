//
//  FeedDetailView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/26.
//

import SwiftUI

struct FeedDetailView: View {
    let images: [String] = ["dunk2", "dunk3", "dunk4"]
    @State var isModel: Bool = false
    var body: some View {
        ScrollView {
//            productDescriptionView()
            productDetailView
            productDetailView2
        }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
            UITabBar.appearance().isHidden = true
        }
            .onDisappear {
            UITabBar.appearance().isHidden = false
        }
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailView()
    }
}

extension FeedDetailView {

    var darkerDivider: some View {
        Color.primary.opacity(0.1)
            .frame(maxWidth: .infinity, maxHeight: 5)
    }

    var productDetailView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("dunk")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 326)
                .clipped()
            Text("Nike Dunk").font(.headline).fontWeight(.medium).padding()
            HStack {
                Text("987,000 원").font(.subheadline).foregroundColor(.gray)
                    .strikethrough()
                Text("80% OFF")
            }.padding(.leading)
            HStack(spacing: -1) {
                Text("197,400").font(.largeTitle)
                Text("원")
                    .baselineOffset(-10)
                Spacer()
            }.padding(.leading)
            Text("12개 남음").font(Font.system(size: 12)).foregroundColor(.red).padding()
            darkerDivider
        }
    }

    var productDetailView2: some View {
        VStack(alignment: .leading) {
            Text("혜택 안내").font(.headline)
            Spacer(minLength: 10)
            Text("아임인 회원 여러분들에게만 안내드리는 아임인과 나이키가 함께하는 특별한 클래식 덩크 제공").font(Font.system(size: 14)).lineLimit(nil)
            Spacer(minLength: 20)
            Text("상품 정보").font(.headline)
            Spacer(minLength: 10)
            Text("오랜만에 돌아온 회빨 덩크! 클래식한 아이템으로 코디하기 아주 좋은 아이템이죠!").font(Font.system(size: 14)).lineLimit(nil)
            productImageScrollView
            productBottmView
        }.padding()

    }

    var productImageScrollView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(images, id: \.self) { image in
                    Image(image).resizable().aspectRatio(contentMode: .fill).frame(width: UIScreen.main.bounds.width - 46).clipped().cornerRadius(15)
                }
            }
        }
    }

    var productBottmView: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: .infinity, height: 60)
            .overlay(
            Text("구매하기").foregroundColor(.white)
        )
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture {
            isModel = true
            print("상품구매!")
        }
            .sheet(isPresented: $isModel, content: {

        })
    }
}


//
//  My.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/27.
//

import SwiftUI

struct My: View {
    @State var isPresented: Bool = false

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack {
                        Image("imgGreetingOfficeM")
                            .resizable()
                            .frame(width: proxy.size.width)
                            .padding(.top, 44)
                        tagView
                            .padding(.leading, 25)
                            .padding(.top, -50)
                            .frame(width: proxy.size.width, alignment: .leading)
                        statusView
                        roundView(proxy: proxy)
                        Text("나의 쇼핑")
                            .font(Font.system(size: 17)).fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 50)
                            .padding(.leading, 25)

                        NavigationLink(destination: DeliveryCheckView()) {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.whiteGray, lineWidth: 2)
                                .frame(width: abs(proxy.size.width - 46), height: 57)
                                .overlay(
                                HStack(spacing: 10) {
                                    Image("btnMyMyorder")
                                    Text("주문/배송 내역")
                                    Spacer()
                                    Image("btnListArrow")
                                }
                                    .padding()
                            )
                                .padding(.top, 10)
                        }

                        myShoppingView(proxy: proxy)

                    }

                }
            }
                .navigationBarTitle("i'm 김호수")
                .navigationBarItems(trailing: Button(action: { }) {
                Image("btnTopSetting")
            })
                .edgesIgnoringSafeArea(.top)
        }
    }


    var tagView: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text("#강남").modifier(CustomHashTagModifier())
                Text("에 살고싶은")
            }
            HStack {
                Text("35세")
                Text("#남성").modifier(CustomHashTagModifier())
                Text("이고")
                Text("#직장인").modifier(CustomHashTagModifier())
            }
            HStack {
                Text("나의 관심사는")
                Text("#음악").modifier(CustomHashTagModifier())
                Text("#게임").modifier(CustomHashTagModifier())
                Text("#요리").modifier(CustomHashTagModifier())
            }
        }
            .font(Font.system(size: 22))
    }

    var statusView: some View {
        HStack(spacing: 40) {
            VStack(alignment: .leading) {
                Text("팔로워").font(Font.system(size: 14))
                Text("1,395").font(Font.system(size: 21)).fontWeight(.medium)
            }
            VStack(alignment: .leading) {
                Text("팔로잉").font(Font.system(size: 14))
                Text("1").font(Font.system(size: 21)).fontWeight(.medium)
            }
            VStack(alignment: .leading) {
                Text("레벨").font(Font.system(size: 14))
                Text("Lv.15").font(Font.system(size: 21)).fontWeight(.medium)
            }
            Spacer()
        }
            .padding(.leading, 25)
            .padding(.top, 30)
    }
}

struct My_Previews: PreviewProvider {
    static var previews: some View {
        My()
    }
}


struct CustomHashTagModifier: ViewModifier {

    let font = Font.system(size: 22).weight(.bold)

    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.allNewPurple)
            .font(font)
    }
}

struct myShoppingView: View {
    var proxy: GeometryProxy

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.whiteGray, lineWidth: 2)
            .frame(width: abs(proxy.size.width - 46), height: 57)
            .overlay(
            HStack(spacing: 10) {
                Image("btnMyReturn")
                Text("반품/교환/환불 내역")
                Spacer()
                Image("btnListArrow")
            }
                .padding()
        )
            .padding(.top, 10)
            .onTapGesture {
        }
    }
}


struct roundView: View {
    var proxy: GeometryProxy

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.whiteGray)
                .frame(width: abs(proxy.size.width - 46), height: 57)
                .overlay(
                HStack(spacing: 10) {
                    Image("btnMyCode").resizable()
                        .frame(width: 24, height: 24, alignment: .leading)
                    Text("추천인 코드 ABCDEF")
                    Spacer()
                    Button("복사") {

                    }
                        .font(Font.system(size: 14).weight(.bold))
                        .foregroundColor(.gray)
                }
                    .padding()
            )
                .padding(.top, 50)

            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.whiteGray, lineWidth: 2)
                .frame(width: abs(proxy.size.width - 46), height: 57)
                .overlay(
                HStack(spacing: 10) {
                    Image("btnMyIpoint")
                    Text("I-POINT")
                    Spacer()
                    Text("35,350P").foregroundColor(.allNewPurple).fontWeight(.medium)
                    Image("btnListArrow")
                }
                    .padding()
            )
                .padding(.top, 10)

            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.whiteGray, lineWidth: 2)
                .frame(width: abs(proxy.size.width - 46), height: 57)
                .overlay(
                HStack(spacing: 10) {
                    Image("btnMyCoupon")
                    Text("쿠폰")
                    Spacer()
                    Text("28").foregroundColor(.gray).fontWeight(.medium)
                    Image("btnListArrow")
                }
                    .padding()
            )
                .padding(.top, 10)
        }
    }
}

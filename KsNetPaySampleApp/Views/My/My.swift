//
//  My.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/27.
//

import SwiftUI

struct My: View {
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack{
                        Image("imgGreetingOfficeM")
                            .resizable()
                            .frame(width: proxy.size.width)
                            tagView
                                .frame(width: proxy.size.width, alignment: .leading)
                                .padding(.leading, 10)
                                .padding(.top, -50)
                    }
//                    .background(Color.green)
                    
                }
            }
            .navigationBarTitle("i'm 김호수")
            .navigationBarItems(trailing: Button(action: {}){
                Image("btnTopSetting")
            })
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    
    var tagView : some View {
        VStack(alignment:.leading) {
            HStack{
                Text("강남").modifier(CustomHashTagModifier())
                Text("에 살고싶은")
            }
            HStack{
                Text("35세")
                Text("남성").modifier(CustomHashTagModifier())
                Text("이고")
                Text("직장인").modifier(CustomHashTagModifier())
            }
            HStack{
                Text("나의 관심사는")
                Text("#음악").modifier(CustomHashTagModifier())
                Text("#게임").modifier(CustomHashTagModifier())
                Text("#요리").modifier(CustomHashTagModifier())
            }
        }
        .border(Color.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

struct My_Previews: PreviewProvider {
    static var previews: some View {
        My()
    }
}


struct CustomHashTagModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 22))
            .foregroundColor(.purple)
    }
}

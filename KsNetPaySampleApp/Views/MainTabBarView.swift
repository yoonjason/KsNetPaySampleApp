//
//  MainTabBarView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import SwiftUI

struct MainTabBarView: View {
    private enum Tabs{
        case Home, Feed, Stage, My
    }
    @State private var selectedTab : Tabs = .Feed
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                home
                feed
                stage
                my
            }
            .accentColor(.primary)
        }
        .accentColor(.black)
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
fileprivate extension View {
    func tabItem(imgae : String, text : String) -> some View {
        self.tabItem {
            Image(imgae)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}

private extension MainTabBarView {
    var Feed2 : some View {
    Feed()
        .tag(Tabs.Feed)
//        .tabItem(image: "icFeed", text: "피드", isSelected: $)
    }
    var home : some View {
        Text("홈")
            .tag(Tabs.Home)
            .tabItem(imgae: "icHomeNor", text: "홈")
    }
    var feed : some View {
        Feed()
            .tag(Tabs.Feed)
            .tabItem(imgae: "icFeedNor", text: "피드")
    }
    var stage : some View {
        Text("스테이지")
            .tag(Tabs.Stage)
            .tabItem(imgae: "icStageNor", text: "스테이지")
    }
    var my : some View {
        Text("나")
            .tag(Tabs.My)
            .tabItem(imgae: "icMyNor", text: "나")
    }
}

//
//  MainTabBarView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import SwiftUI

enum Tabs {
    case Home, Feed, Stage, My
}

struct MainTabBarView: View {

    @State private var selectedTab: Tabs = .Feed

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
            .background(Color.white)
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
    func tabItem(imgae: String, text: String) -> some View {
        self.tabItem {
            Image(imgae)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}

private extension MainTabBarView {

    var home: some View {
        Home(viewModel: SignViewModel())
            .tag(Tabs.Home)
            .tabItem(imgae: self.selectedTab == .Home ? "icHomeSelect" : "icHomeNor", text: "홈")
    }
    var feed: some View {
        Feed()
            .tag(Tabs.Feed)
            .tabItem(imgae: self.selectedTab == .Feed ? "icFeedSelect" : "icFeedNor", text: "피드")
            .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
    var stage: some View {
        Text("스테이지")
            .tag(Tabs.Stage)
            .tabItem(imgae: self.selectedTab == .Stage ? "icStageSelect" : "icStageNor", text: "스테이지")
    }
    var my: some View {
        My()
            .tag(Tabs.My)
            .tabItem(imgae: self.selectedTab == .My ? "icMySelect" : "icMyNor", text: "나")
    }
}

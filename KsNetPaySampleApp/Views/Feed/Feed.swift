//
//  Feed.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import SwiftUI

struct Feed: View {

    var body: some View {
        NavigationView {
            VStack {
                List(feedSamples) { feed in
                    FeedRow(feed: feed)
                    NavigationLink(
                        destination: FeedDetailView()) {
                        EmptyView()
                    }.frame(width:0).hidden()
                }
//                .listRowInsets(EdgeInsets())
                .listStyle(PlainListStyle())
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Feed")
        }

    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}

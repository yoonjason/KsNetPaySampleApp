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
                Text("Feed")
                List(feedSamples) { feed in
                    FeedRow()
                }
            }
                .navigationBarTitle("Feed")
        }
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}

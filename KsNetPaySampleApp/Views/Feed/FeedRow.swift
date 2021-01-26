//
//  FeedRow.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import SwiftUI

struct FeedRow: View {
    let feed : Feeds
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack(spacing:5) {
                Image("\(feed.profileImage)")
                    .resizable()
                    .frame(width: 42, height: 42)
                VStack(alignment:.leading) {
                    Text(feed.name).fontWeight(.semibold)
                    Text("2020년 10월 25일 오전 10:00").font(Font.system(size: 13)).foregroundColor(.gray)
                }
            }
            Text(feed.description).font(Font.system(size: 14)).lineLimit(3)
            Image("\(feed.image)").resizable().aspectRatio(contentMode: .fill).frame(height: 247).clipped().cornerRadius(15)
            HStack(spacing:8){
                Spacer()
                Text("좋아요 \(feed.likeCount)")
                Text("댓글 \(feed.replyCount)  ")
            }
            .font(Font.system(size: 15))
            .foregroundColor(.gray)
            
        }
//        .padding()
    }

}

struct FeedRow_Previews: PreviewProvider {
    static var previews: some View {
        FeedRow(feed: feedSamples[0])
    }
}

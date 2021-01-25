//
//  FeedData.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//


import Foundation

class FeedData : ObservableObject {
    @Published var feedData : [Feeds]
    
    init(feedData : [Feeds]) {
        self.feedData = feedData
    }
}

struct Feeds : Codable, Equatable, Identifiable {
    var id : String {
        name
    }
    
    var name : String
    var profileImage : String
    var description : String
    var likeCount : Int
    var replyCount : Int
}


let feedSamples = [
    Feeds(name: "twice", profileImage: "", description: "피규어 수집 좋아하시는분들 안계시나요?? 나이가 먹었는데도 아직까지 원피스 웹툰이나 영화가 올라오면 항상 보러가네요 친구가 오덕 같다고해도 무시ㅋㅋㅋ 다들 한가지 취미 같은거 가지고 계시잔아여~저는 피규어 모으는게 취미에요^^ 피규어가 모으다 보니 돈이 만만치 않게 들더라구요. 피규어 좋아하시는 분들 함께 목돈 마련해요!", likeCount: 5, replyCount: 4),
    Feeds(name: "아임인", profileImage: "", description: "<회원님을 위한 상품 추천 80% OFF> \n 패딩계의 명품! 몽클레어 패딩을 최대 80% 할인된 \n에 만나보세요! 선착순 100분께 할인혜택을 드립니다.", likeCount: 98, replyCount: 5),
    Feeds(name: "twice", profileImage: "", description: "피규어 수집 좋아하시는분들 안계시나요?? 나이가 먹었는데도 아직까지 원피스 웹툰이나 영화가 올라오면 항상 보러가네요 친구가 오덕 같다고해도 무시ㅋㅋㅋ 다들 한가지 취미 같은거 가지고 계시잔아여~저는 피규어 모으는게 취미에요^^ 피규어가 모으다 보니 돈이 만만치 않게 들더라구요. 피규어 좋아하시는 분들 함께 목돈 마련해요!", likeCount: 0, replyCount: 1)
    
]


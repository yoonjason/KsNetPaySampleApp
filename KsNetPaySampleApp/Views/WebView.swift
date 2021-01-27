//
//  WebView.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/27.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import WebKit

struct WebView: UIViewRepresentable {
    var url: String
    @ObservedObject var viewModel: WebViewModel

    ///변경 사항을 전달하는 데 사용하는 사용자 지정 인스턴스이다 //뷰 컨트롤러를 변경하면 앱의 다른 부분에 영향을 미칠 수있는 경우
    func makeCoordinator() -> Coordinator {

        print(#function)
        return Coordinator(self)
    }

    func getHtml() -> String {
        let localFilePath = Bundle.main.path(forResource: "main", ofType: "html")
        print(localFilePath)
        return localFilePath!
    }


    ///뷰 객체를 생성하고 초기 상태를 구성한다. 딱 한번만 호출한다.
    func makeUIView(context: Context) -> WKWebView {
        print(#function)

        ///웹 사이트에 적용할 표준 동작을 캡슐화하는 개체
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always


        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences


        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.configuration.processPool.perform(Selector(("_setCookieAcceptPolicy:")), with: HTTPCookie.AcceptPolicy.always)
        webView.navigationDelegate = context.coordinator //웹보기의 탐색 동작을 관리하는 데 사용되는 개체
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true

//        if let url = URL(string: url) {
//            webView.load(URLRequest(url: url))
//        }

        let url = URL(fileURLWithPath: getHtml())
        let request = URLRequest(url: url)
        webView.load(request)


        return webView
    }

    /// 지정된 뷰의 상태를 다음의 새 정보로 업데이트 합니다.
    func updateUIView(_ uiView: WKWebView, context: Context) {

    }

    ///탐색 변경을 수락 또는 거부하고 탐색 요청의 진행 상황을 추적
    class Coordinator: NSObject, WKNavigationDelegate {

        var parent: WebView
        var foo: AnyCancellable? = nil

        init(_ uiWebView: WebView) {
            parent = uiWebView
            print(#function)
        }

        deinit {
            foo?.cancel()
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("내용을 수신하기 시작")
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("탐색 완료")
        }


        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let host = navigationAction.request.url?.host {
                //특정 도메인을 제외한 도메인을 연결하지 못하게 할 수 있다.
                /*
                 if host != "velog.io" {
                     return decisionHandler(.cancel)
                 }
                 */
            }

            parent.viewModel.bar.send(false)
            self.foo = self.parent.viewModel.foo.receive(on: RunLoop.main).sink(receiveValue: { (value) in
                print(value)
            })

            return decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("기본 프레임에서 탐색이 시작되었음")
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("초기 탐색 프로세스 중에 오류가 발생했음")
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("탐색 중에 오류가 발생했음")
        }



    }
}

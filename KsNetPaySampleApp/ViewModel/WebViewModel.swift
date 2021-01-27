//
//  WebViewModel.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/27.
//

import Foundation
import Combine

class WebViewModel : ObservableObject {
    
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}

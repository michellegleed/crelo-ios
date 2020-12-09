//
//  ImageLoader.swift
//  crelo
//
//  Created by michelle gleed on 8/9/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//
// From HackingWithSwift:  https://www.hackingwithswift.com/forums/swiftui/loading-images/3292


import Foundation
import SwiftUI

struct ImageFromURL: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        @Published var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    DispatchQueue.main.async {
                        self.state = .success
                   }
                } else {
                    DispatchQueue.main.async {
                        self.state = .failure
                   }
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @ObservedObject private var loader: Loader
    
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = ObservedObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

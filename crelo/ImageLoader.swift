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
                print("started image fetch")
                if let data = data, data.count > 0 {
                    print("got back data")
                    self.data = data
                    DispatchQueue.main.async {
                        print("updating state to .success")
//                       self.objectWillChange.send()
                        self.state = .success
                   }
                } else {
                    DispatchQueue.main.async {
                        print("updating state to .failure")
    //                       self.objectWillChange.send()
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
            print("image is loading")
            return loading
        case .failure:
            print("fetch image failed")
            return failure
        default:
            print("generating image from url")
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

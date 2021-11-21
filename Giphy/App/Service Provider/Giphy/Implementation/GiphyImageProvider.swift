//
//  GiphyImageProvider.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

class GiphyImageProvider {
    // MARK: - Network
    private let session: URLSession
    private let timeout: TimeInterval = .init(5)
    private var request: URLSessionDataTask? = nil
    
    // MARK: - Json Decoder
    private let decoder: JSONDecoder = .init()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
}

extension GiphyImageProvider: TrendingTermsProviderProtocol {
    func search(success: @escaping TrendingTermsProviderProtocol.Success, failure: @escaping TrendingTermsProviderProtocol.Failure) {
        guard let url = self.createTrendingTermsURL() else {
            failure(UseCaseError.Client.badURL)
            return
        }
        
        self.request?.cancel()
        let request = URLRequest(url: url, timeoutInterval: self.timeout)
        
        self.request = self.session.dataTask(with: request, completionHandler: { data, response, error in
            guard self.proccess(error: error, block: failure) == false else { return }
            guard self.proccess(response: response, block: failure) else { return }
            guard let data = data else { return }

            
            do {
                let giphyTrendingSearchResponse = try self.decoder.decode(GiphyResponse<[String]>.self, from: data)
                success(giphyTrendingSearchResponse.data)
            } catch {
                failure(error)
            }
        })
        
        self.request?.resume()
    }
}

// MARK: - Image Provider Protocol
extension GiphyImageProvider: ImageProviderProtocol {
    func search(parameters: ImageProviderParameters.Search, success: @escaping (ImageProviderData) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = self.createSearchURL(parameters: parameters) else {
            failure(UseCaseError.Client.badURL)
            return
        }
        
        self.request?.cancel()
        let request = URLRequest(url: url, timeoutInterval: self.timeout)
        
        self.request = self.session.dataTask(with: request) { data, response, error in
            guard self.proccess(error: error, block: failure) == false else { return }
            guard self.proccess(response: response, block: failure) else { return }
            guard let data = data else { return }
            
            do {
                let giphySearchResponse = try self.decoder.decode(GiphyResponse<[GiphyGIF]>.self, from: data)
                
                let imageProviderData = giphySearchResponse.convert()
                if imageProviderData.images.isEmpty {
                    failure(UseCaseError.Others.empty)
                } else {
                    success(imageProviderData)
                }
            } catch {
                failure(UseCaseError.Others.decoding)
            }
        }
        
        self.request?.resume()
    }
}

private extension GiphyImageProvider {
    func proccess(error: Error?, block: (Error) -> Void) -> Bool {
        guard let nserror = error as NSError? else { return false }
        
        let error: Error
        
        switch nserror.code {
        case NSURLErrorTimedOut: error = UseCaseError.Network.timeout
        default: error = UseCaseError.Network.unknown
        }
        
        block(error)
        return true
    }
    func proccess(response: URLResponse?, block: (Error) -> Void) -> Bool {
        guard let httpURLresponse = response as? HTTPURLResponse else { return false }
        
        if 200..<300 ~= httpURLresponse.statusCode { return true }
        
        let error: Error
        
        switch httpURLresponse.statusCode {
        case 500..<600: error = UseCaseError.Server.unknown
        case 400: error = UseCaseError.Client.badRequest
        case 403: error = UseCaseError.Client.forbidden
        case 404: error = UseCaseError.Client.notFound
        case 429: error = UseCaseError.Client.tooManyRequests
        default: error = UseCaseError.Others.unknown
        }
        
        block(error)
        return false
    }
}

private extension GiphyImageProvider {
    func createSearchURL(parameters: ImageProviderParameters.Search) -> URL? {
        var components = URLComponents()
        components.scheme = .scheme
        components.host = .host
        
        if parameters.type == 0 {
            components.path = .search
        } else {
            components.path = .searchStickers
        }
        
        components.queryItems = [
            .init(name: "api_key", value: .apiKey),
            .init(name: "q", value: parameters.query),
            .init(name: "limit", value: "\(parameters.size)"),
            .init(name: "offset", value: "\(parameters.offset)"),
            .init(name: "bundle", value: .bundle)
        ]
        
        return components.url
    }
    
    func createTrendingTermsURL() -> URL? {
        var components = URLComponents()
        components.scheme = .scheme
        components.host = .host
        components.path = .trendingSearch
        components.queryItems = [
            .init(name: "api_key", value: .apiKey)
        ]
        
        return components.url
    }
}

// MARK: - Giphy Model Extension
private extension GiphyResponse where T == [GiphyGIF] {
    func convert() -> ImageProviderData {
        let images: [ImageProviderImage] = self.data.compactMap({
            let thumbnail = $0.images?.fixedWidth?.url ?? ""
            let thumbnailWidth = Int($0.images?.fixedWidth?.width ?? "") ?? 0
            let thumbnailHeight = Int($0.images?.fixedWidth?.height ?? "") ?? 0
            let original = $0.images?.original?.url ?? ""
            var image = ImageProviderImage(thumbnail: thumbnail,
                                           original: original,
                                           width: thumbnailWidth,
                                           height: thumbnailHeight)
            
            if let user = $0.user,
               let primaryName = user.displayName,
               let secondaryName = user.userName,
               let avatarURL = user.avatarURL {
                
                let user = ImageProviderImage.User(primaryName: primaryName,
                                                   secondaryName: secondaryName,
                                                   avatarURL: avatarURL)
                image.user = user
                image.isAvailableUserProfile = true
            } else if let sourceTLD = $0.sourceTLD,
                      sourceTLD.isEmpty == false {
                let primaryName = sourceTLD
                let secondaryName = "Source"
                
                let user = ImageProviderImage.User(primaryName: primaryName, secondaryName: secondaryName, avatarURL: "")
                image.user = user
            }
            
            image.uniqueID = $0.id ?? ""
            
            return image
        })
        
        return .init(images: images)
    }
}

// MARK: - String Extension
private extension String {
    // GIPHY API KEY
    static let apiKey = "4qICcfkeghYtD22N7Utn2MJ7bJi2kZ4Q"
    
    /// GIPHY API URL 스킴
    static let scheme = "https"
    
    /// GIPHY API URL 호스트
    static let host = "api.giphy.com"
    
    /// GIPHY API - Search Endpoint의 URL 경로
    static let search = "/v1/gifs/search"
    
    /// GIPHY API - Search Stickers Endpoint의 URL 경로
    static let searchStickers = "/v1/stickers/search"
    
    /// GIPHY API - Trending Searches Endpoint의 URL 경로
    static let trendingSearch = "/v1/trending/searches"
    
    /// GIPHY API — Search Endpoint의 `bundle` 파라미터 값
    static let bundle = "messaging_non_clips"
}

// MARK: - Business Logic Layer Extension
private extension ImageProviderParameters.Search {
    var offset: Int { return self.size * self.page }
}

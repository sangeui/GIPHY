//
//  GiphySearchImages.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct GiphyImages: Decodable {
    // MARK: Fixed Height
    var fixedHeight: GiphyImage?
    var fixedHeightStill: GiphyImage?
    var fixedHeightDownsampled: GiphyImage?
    
    var fixedHeightSmall: GiphyImage?
    var fixedHeightSmallStill: GiphyImage?
    
    // MARK: - Fixed Width
    var fixedWidth: GiphyImage?
    var fixedWidthStill: GiphyImage?
    var fixedWidthDownsampled: GiphyImage?
    
    var fixedWidthSmall: GiphyImage?
    var fixedWidthSmallStill: GiphyImage?
    
    // MARK: - Downsized
    var downsized: GiphyImage?
    var downsizedStill: GiphyImage?
    var downsizedLarge: GiphyImage?
    var downsizedMedium: GiphyImage?
    var downsizedSmall: GiphyImage?
    
    // MARK: - Original
    var original: GiphyImage?
    var originalStill: GiphyImage?
    
    // MARK: - Looping
    var looping: GiphyImage?
    
    // MARK: - Preview
    var preview: GiphyImage?
    var previewGIF: GiphyImage?
}

extension GiphyImages {
    enum CodingKeys: String, CodingKey {
        // MARK: - Coding Keys — Fixed Height
        case fixedHeight = "fixed_height"
        case fixedHeightStill = "fixed_height_still"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        
        // MARK: - Coding Keys — Fixed Width
        case fixedWidth = "fixed_width"
        case fixedWidthStill = "fixed_width_still"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        
        // MARK: - Coding Keys — Downsized
        case downsized
        case downsizedStill = "downsized_still"
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        
        // MARK: - Coding Keys — Original
        case original
        case originalStill = "original_still"
        
        // MARK: - Coding Keys - Looping
        case looping
        
        // MARK: - Coding Keys - Preview
        case preview
        case previewGIF = "preview_gif"
    }
}

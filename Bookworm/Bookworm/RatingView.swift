//
//  RatingView.swift
//  Bookworm
//
//  Created by Frank Chu on 4/6/22.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var labelByF = ""
    
    var maximumRating = 5
    
    var onImageByF = Image(systemName: "star.fill")
    var offImageByF: Image?
    
    var offColorByF = Color.gray
    var onColorByF = Color.yellow
    
    var body: some View {
        HStack {
//            if labelByF.isEmpty == false {
//                Text(labelByF)
//            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { numberTemp in
                imageByF(for: numberTemp)
                    .foregroundColor(numberTemp > rating ? offColorByF : onColorByF)
                    .onTapGesture {
                        rating = numberTemp
                    }
            }
        }
    }
    
    func imageByF(for number: Int) -> Image {
        return onImageByF
//        if number > rating {
//            return offImageByF ?? onImageByF
//        } else {
//            return onImageByF
//        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(2))
    }
}

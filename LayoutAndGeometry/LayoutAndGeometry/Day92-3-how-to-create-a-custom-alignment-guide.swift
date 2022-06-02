//
//  Day92-3-how-to-create-a-custom-alignment-guide.swift
//  LayoutAndGeometry
//
//  Created by Frank Chu on 5/30/22.
//

import SwiftUI

struct Day92_3_how_to_create_a_custom_alignment_guide: View {
    var body: some View {
        VStack {
            HStack(alignment: .midAccountAndName) {
                VStack {
                    Text("@twostarws")
                        .alignmentGuide(.midAccountAndName) { d in
                            d[VerticalAlignment.center]
                        }
                    Image("Example")
                        .resizable()
                        .frame(width: 64, height: 64)
                    
                }
                VStack {
                    Text("Full name:")
                        
                    Text("PAUL HUDSON")
                        .alignmentGuide(.midAccountAndName) { d in
                            d[VerticalAlignment.center]
                        }
                        .font(.largeTitle)
                }
            }
            .background(.red)
            
//            HStack(alignment: .top) {
            HStack {
                VStack {
                    Text("@twostraws")
                    Image("Example")
                        .resizable()
                        .frame(width: 64, height: 64)
                }

                VStack {
                    Text("Full name:")
                    Text("PAUL HUDSON")
                        .font(.largeTitle)
                }
            }
            .background(.red)
        }
        
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct Day92_3_how_to_create_a_custom_alignment_guide_Previews: PreviewProvider {
    static var previews: some View {
        Day92_3_how_to_create_a_custom_alignment_guide()
    }
}

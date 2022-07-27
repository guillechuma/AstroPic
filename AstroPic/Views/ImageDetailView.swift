//
//  ImageDetailView.swift
//  AstroPic
//
//  Created by Guillermo Chumaceiro on 27/7/22.
//

import SwiftUI

struct ImageDetailView: View {
    
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: Image("previewImage"))
    }
}

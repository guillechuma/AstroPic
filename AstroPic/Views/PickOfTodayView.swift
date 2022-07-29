//
//  PickOfTodayView.swift
//  AstroPic
//
//  Created by Guillermo Chumaceiro on 26/7/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct PickOfTodayView: View {
    
    @ObservedObject var manager = NetworkManager()
    
    // Popover
    @State private var showSwitchDate: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            HStack {
                Image("nasa_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Text("AstroPic")
                    .font(.largeTitle.bold())
                Button {
                    self.showSwitchDate.toggle()
                } label: {
                    Image(systemName: "calendar")
                    Text("Switch Day")
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .popover(isPresented: $showSwitchDate) {
                    SelectDateView(manager: manager)
                }
            }

            
            // Display image of the day
            if let image = manager.image {
                image
                    .resizable()
                    .scaledToFit()
                    .padding()
            } else {
                LoadingIndicator()
                    .frame(height: 300)
                    .padding()
            }
            
            Text(manager.photoInfo.date)
                .font(.title)
            Text(manager.photoInfo.title)
                .font(.headline)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(manager.photoInfo.description)
                }
            }
            .padding()
        }
    }
}

struct PickOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PickOfTodayView()
        view.manager.photoInfo = PhotoInfo.createDefault()
        view.manager.image = Image("previewImage")
        return view
    }
}

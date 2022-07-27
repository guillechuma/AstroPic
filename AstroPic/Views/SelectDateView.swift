//
//  SelectDateView.swift
//  AstroPic
//
//  Created by Guillermo Chumaceiro on 27/7/22.
//

import SwiftUI

struct SelectDateView: View {
    
    @State private var date = Date()
    
    @ObservedObject var manager: NetworkManager
    
    // Environment var for presentation mode
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Select a day")
                .font(.headline)
            DatePicker(selection: $date, in: ...Date(), displayedComponents: [.date]) {
                Text("select")
            }
            .labelsHidden()
            .datePickerStyle(.automatic)
            
            
            Button {
                manager.date = date
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Done")
            }
            .padding()

        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manager: NetworkManager())
    }
}

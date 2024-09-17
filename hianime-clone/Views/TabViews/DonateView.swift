//
//  DonateView.swift
//  hianime-clone
//
//  Created by apple on 13/08/24.
//

import SwiftUI

struct DonateView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "heart.fill")
                .scaleEffect(5)
                .frame(width: 100, height: 100)
            
            Text("Support US!")
            
            Image("qr")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
            
            Text("Scan the QR to help us grow!")
            
        }
    }
}

#Preview {
    DonateView()
}

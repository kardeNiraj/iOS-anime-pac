//
//  PaginationView.swift
//  hianime-clone
//
//  Created by apple on 28/08/24.
//

import SwiftUI

struct PaginationView: View {
    @Binding var currentPage: Int
    var totalPages: Int
    var itemsPerPage: Int
    var totalItems: Int
    var onPageChange: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                if currentPage > 1 {
                    currentPage -= 1
                    onPageChange(currentPage)
                }
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(currentPage > 1 ? .red : .gray)
            }
            .disabled(currentPage == 1)
            
            Spacer()
            
                        
            Menu {
                ForEach(1...totalPages, id: \.self) { page in
                    Button(action: {
                        currentPage = page
                        onPageChange(currentPage)
                    }) {
                        Text("\((page - 1) * itemsPerPage + 1)-\(min(page * itemsPerPage, totalItems))")
                    }
                }
            } label: {
                Text("\(startEpisode) - \(endEpisode) of \(totalItems)")
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .foregroundStyle(Color.white)
                    .cornerRadius(8)
            }
            
            Spacer()
            
            Button(action: {
                if currentPage < totalPages {
                    currentPage += 1
                    onPageChange(currentPage)
                }
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(currentPage < totalPages ? .red : .gray)
            }
            .disabled(currentPage == totalPages)
        }
        .padding(.top, 12)
    }
    
    private var startEpisode: Int {
        return (currentPage - 1) * itemsPerPage + 1
    }
    
    private var endEpisode: Int {
        return min(currentPage * itemsPerPage, totalItems)
    }
}

#Preview {
    PaginationView(currentPage: .constant(1), totalPages: 10, itemsPerPage: 10, totalItems: 95, onPageChange: { _ in })
}

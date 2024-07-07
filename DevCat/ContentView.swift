//
//  ContentView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCategory: CategoryType? = .encoding
    @State private var selectedProduct: Product?

    var body: some View {
        NavigationSplitView {
            List(CategoryType.allCases) { category in
                Label(category.localizedName, systemImage: category.icon)
                    .onTapGesture {
                        selectedCategory = category
                        selectedProduct = nil
                    }
            }
        } content: {
            VStack(alignment: .leading) {
                if let selectedCategory = selectedCategory {
                    ForEach(selectedCategory.products) { product in
                        Text(product.name)
                            .padding(.vertical, 4) // 增加垂直边距
//                            .padding(.horizontal, 10) // 增加水平边距
//                            .cornerRadius(8) // 圆角
//                            .shadow(radius: 2) // 添加阴影
                            .onTapGesture {
                                selectedProduct = product
                            }
                    }
                    .navigationTitle(selectedCategory.localizedName)
                } else {
                    Text("Select a category")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Align content to the top leading corner
            .padding() // Add padding to avoid content touching the edges
        } detail: {
            if let selectedProduct {
                selectedProduct.detailView
            } else {
                Text("Select a product")
            }
        }
    }
}

#Preview {
    ContentView()
}

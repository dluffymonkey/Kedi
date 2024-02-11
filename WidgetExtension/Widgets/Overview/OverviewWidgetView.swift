//
//  OverviewWidgetView.swift
//  WidgetExtension
//
//  Created by Saffet Emin Reisoğlu on 2/10/24.
//

import SwiftUI

struct OverviewWidgetView : View {
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: OverviewWidgetProvider.Entry

    var body: some View {
        ZStack {
            switch widgetFamily {
            case .systemSmall:
                Grid {
                    ForEach(Array(entry.items3.enumerated()), id: \.offset) { index, item in
                        GridRow {
                            makeGridItem(item: item)
                        }
                        .frame(maxHeight: .infinity)
                        
                        if index != 2 {
                            RoundedRectangle(cornerRadius: 1)
                                .fill(Color.opaqueSeparator)
                                .frame(height: 1)
                        }
                    }
                }
                .padding()
                
            case .systemMedium:
                ZStack {
                    Grid(horizontalSpacing: 30) {
                        ForEach(Array(entry.items.chunked(by: 2).enumerated()), id: \.offset) { index, items in
                            GridRow {
                                ForEach(items, id: \.self) { item in
                                    makeGridItem(item: item)
                                }
                            }
                            .frame(maxHeight: .infinity)
                            
                            if index != 2 {
                                HStack(spacing: 30) {
                                    RoundedRectangle(cornerRadius: 1)
                                        .fill(Color.opaqueSeparator)
                                        .frame(height: 1)
                                    
                                    RoundedRectangle(cornerRadius: 1)
                                        .fill(Color.opaqueSeparator)
                                        .frame(height: 1)
                                }
                            }
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.opaqueSeparator)
                        .frame(width: 1)
                }
                .padding()
                
            default:
                Text("Unsupported widget family!")
            }
            
            if let message = entry.error?.localizedDescription {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                }
                .padding(.horizontal)
                .padding(.bottom, 2)
            }
        }
    }
    
    private func makeGridItem(item: OverviewItem) -> some View {
        HStack {
            VStack(alignment: .center) {
                Image(systemName: item.type.icon)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(item.type.color)
            }.frame(width: 30)
            
            Spacer()
            
            Text(item.value)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

#Preview {
    OverviewWidgetView(entry: .placeholder)
}

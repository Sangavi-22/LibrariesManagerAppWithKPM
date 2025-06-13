//
//  ShimmerView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import SwiftUI
struct ShimmerView: View {
    
    let sectionHeaderLabelHeight: CGFloat
    
    let rowPerSection: Int
    let rowHeaderHeight: CGFloat
    let rowContentHeight: CGFloat
    let spacingBetweenRowHeaderAndContent: CGFloat
    let spacingBetweenRows: CGFloat
    
    let spacingBetweenSectionHeaderAndRows: CGFloat
    let spacingBetweenSections: CGFloat
    
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    
    init(sectionHeaderLabelHeight: CGFloat = 16,
         rowPerSection: Int = 2,
         rowHeaderHeight: CGFloat = 16,
         rowContentHeight: CGFloat = 16,
         spacingBetweenRowHeaderAndContent: CGFloat = 12,
         spacingBetweenRows: CGFloat = 40,
         spacingBetweenSectionHeaderAndRows: CGFloat = 32,
         spacingBetweenSections: CGFloat = 56,
         horizontalPadding: CGFloat = 16,
         verticalPadding: CGFloat = 24) {
        self.sectionHeaderLabelHeight = sectionHeaderLabelHeight
        self.rowPerSection = rowPerSection
        self.rowHeaderHeight = rowHeaderHeight
        self.rowContentHeight = rowContentHeight
        self.spacingBetweenRowHeaderAndContent = spacingBetweenRowHeaderAndContent
        self.spacingBetweenRows = spacingBetweenRows
        self.spacingBetweenSectionHeaderAndRows = spacingBetweenSectionHeaderAndRows
        self.spacingBetweenSections = spacingBetweenSections
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            // Calculating total height of each individual row
            let individualRowHeight: CGFloat = rowHeaderHeight + spacingBetweenRowHeaderAndContent + rowContentHeight
            
            // Calculating the total height of the row container in the section
            let totalRowHeight: CGFloat = CGFloat(rowPerSection) * individualRowHeight
            
            // Calculate the total height of all spacing between rows
            let totalRowSpacing: CGFloat = CGFloat(rowPerSection - 1) * spacingBetweenRows
            
            // Calculate the total height of a section
            let totalHeightOfASection: CGFloat = sectionHeaderLabelHeight +
            spacingBetweenSectionHeaderAndRows +
            totalRowHeight +
            totalRowSpacing
            
            let geometryWidth = geometry.size.width
            let geometryHeight = geometry.size.height
            let sectionCount: Int = Int((geometryHeight) / totalHeightOfASection)
            
            VStack(alignment: .leading, spacing: spacingBetweenSections) {
                ForEach(0..<sectionCount, id: \.self) { index in
                    // Building the sections
                    VStack(alignment: .leading, spacing: spacingBetweenSectionHeaderAndRows) {
                        buildSectionHeader(with: geometryWidth)
                        
                        // Building the rows
                        VStack(alignment: .leading, spacing: spacingBetweenRows) {
                            ForEach(0..<rowPerSection, id: \.self) { _ in
                                buildSectionRows(with: geometryWidth)
                            }
                        }
                    }
                    .opacity(min(1.0 - (Double(index) * 0.3), 1.0))
                }
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(width: geometryWidth, height: geometryHeight, alignment: .topLeading)
        }
    }
    
    private func buildSectionHeader(with width: CGFloat) -> some View {
        CommonShimmer()
            .frame(width: width / 2.5, height: sectionHeaderLabelHeight)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func buildSectionRows(with width: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: spacingBetweenRowHeaderAndContent) {
            //Row Header
            CommonShimmer()
                .frame(width: width / 3.5, height: rowHeaderHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            //Row Content
            CommonShimmer()
                .frame(width: width / 2, height: rowContentHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct CommonShimmer: View {
    private var gradientColors = [
        Color(UIColor.systemGray5),
        Color(UIColor.systemGray6),
        Color(UIColor.systemGray5),
       
    ]
    @State var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    var body: some View {
        LinearGradient (colors: gradientColors,
                        startPoint: startPoint, endPoint: endPoint)
        .onAppear {
            withAnimation(.easeInOut (duration: 1)
                .repeatForever(autoreverses: false)) {
                startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
            }
        }
    }
}

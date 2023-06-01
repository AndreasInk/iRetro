//
//  VinylRecordView.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas Ink on 5/31/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct VinylRecordView: View {
   
    let numGrooves = 100
    let recordColor = Color.black
    let grooveColor = Color.gray
    @EnvironmentObject var vm: DisplayViewModel
    @State var animate = false
    var body: some View {
        ZStack {
            // Outer Vinyl Record Circle
            Circle()
                .fill(recordColor)
                .frame(width: 300, height: 300)
            
            // Draw grooves
            ForEach(0..<numGrooves, id: \.self) { groove in
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(groove % 2 == 0 ? self.recordColor : self.grooveColor)
                    .frame(width: CGFloat(300 - groove * 2), height: CGFloat(300 - groove * 2))
            }
            
            // Inner Record Label Circle
            artwork()
                .overlay {
                    Circle()
                        .fill(.ultraThinMaterial)
                }
                .clipShape(Circle())
            
            // Innermost Hole in the Vinyl
            Circle()
                .fill(Color.black)
                .frame(width: 50, height: 50)
            
            // Shiny light effect
            RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0)]), center: .topLeading, startRadius: 10, endRadius: 200)
                .blendMode(.overlay)
        }
        .rotationEffect(Angle(degrees: animate ? 3600 : 0))
        .onAppear {
            withAnimation(.easeInOut(duration: 30)) {
                animate = true
            }
        }
        
    }
    private func artwork(withHeightFactor heightFactor: CGFloat = 1) -> some View {
        Image(uiImage: vm.artwork?.image(at: CGSize(width: 150, height: 150)) ?? UIImage(named: "abbeyRoad")!)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
    }

}



@available(iOS 15.0, *)
struct VinylView_Previews: PreviewProvider {
    static var previews: some View {
        VinylRecordView()
    }
}

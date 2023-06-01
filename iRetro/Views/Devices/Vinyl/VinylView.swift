//
//  WinylView.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas Ink on 5/31/23.
//

import SwiftUI


struct VinylView: View {
    @StateObject private var vm = DisplayViewModel()
    @State private var swipedUp = false
    @State private var offset = CGSize.zero
    let slide = Animation.interpolatingSpring(mass: 0.21, stiffness: 2.8, damping: 1.28, initialVelocity: 1.0)
    let ease = Animation.interpolatingSpring(mass: 0.42, stiffness: 5.85, damping: 1.85, initialVelocity: 4.2)
    var body: some View {
        VStack {
            VinylRecordView()
                .environmentObject(vm)
                .offset(offset)
                .opacity(abs(offset.height) > 500 ? 0 : 1)
                .gesture (
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            let offset = value.translation
                            if abs(offset.height) < 50 || abs(offset.width) < 50 {
                                withAnimation(slide) {
                                    self.offset = CGSize(width: offset.width * 10,
                                                         height: offset.height * 10)
                                    if offset.height < 0 {
                                        MusicManager.shared.next()
                                    } else {
                                        MusicManager.shared.previous()
                                    }
                                }
                            }
                            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                                DispatchQueue.main.async {
                                    withAnimation(slide) {
                                        self.offset = .zero
                                    }
                                }
                            }
                        }
                )
        }
        .onAppear {
            vm.startNowPlayingSubscriptions()
        }
        
    }
}

struct VinylRecordView_Previews: PreviewProvider {
    static var previews: some View {
        VinylRecordView()
    }
}

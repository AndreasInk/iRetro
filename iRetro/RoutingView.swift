//
//  RoutingView.swift
//  iRetro
//
//  Created by Andreas on 2/21/21.
//

import SwiftUI

struct RoutingView: View {
//    @AppStorage("firstRun") var firstRun: Bool = true
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false

    var body: some View {
        if isOnboardingCompleted {
            VinylView()
        } else {
            OnboardingView()
        }
    }
}

struct RoutingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingView()
    }
}

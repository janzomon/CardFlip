//
//  ContentView.swift
//  CardFlip
//
//  Created by Damon gonzalez on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var showView: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    if showView {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.red)
                            .transition(.reverseFlip)
                    }
                    else {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                            .transition(.flip)
                    }
                }
                .frame(width: 200, height: 300)
                .onTapGesture {
                    withAnimation(.bouncy(duration: 2)){
                        showView.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}




struct FlipTransition:ViewModifier, Animatable {
    var progress:CGFloat = 0.0
    var animatableData:CGFloat {
        get { progress }
        set { progress = newValue }
    }
    func body(content: Content) -> some View {
        content
            .opacity(progress < 0 ? (-progress < 0.5 ? 1:0):(progress < 0.5 ? 1:0))
            .rotation3DEffect(
                .init(degrees: progress * 180),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}



extension AnyTransition {
    static let flip:AnyTransition = .modifier(
        active: FlipTransition(progress: -1),
        identity: FlipTransition()
    )
    
    static let reverseFlip:AnyTransition = .modifier(
        active: FlipTransition(progress: 1),
        identity: FlipTransition()
    )
}

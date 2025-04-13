//
//  StoryView.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import SwiftUI

struct StoryView: View {
    @ObservedObject var viewModel: StoryViewViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 12) {
                Text(viewModel.user.name)
                    .font(.largeTitle)
                ZStack {
                    AsyncImage(url: URL(string: viewModel.user.profilePictureUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .modifier(RoundedImage(size: geometry.size.width))
                    
                    HStack {
                        if viewModel.canNavigateLeft {
                            NavigationButton(imageName: "chevron.left") {
                                viewModel.didTapLeft()
                            }
                        }
                        
                        Spacer()
                        
                        if viewModel.canNavigateRight {
                            NavigationButton(imageName: "chevron.right") {
                                viewModel.didTapRight()
                            }
                        }
                    }
                }
                
                HStack {
                    Button {
                        viewModel.didTapLike()
                    } label: {
                        Image(systemName: viewModel.isLiked ? "hand.thumbsup" : "hand.thumbsdown")
                            .font(.largeTitle)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct NavigationButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 44, height: 44)
                Image(systemName: imageName)
            }
        }
        .padding(.horizontal, 4)
    }
}

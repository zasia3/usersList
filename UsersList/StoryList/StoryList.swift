//
//  ContentView.swift
//  UsersList
//
//  Created by Joanna Zatorska on 09/04/2025.
//

import SwiftUI
import Combine

struct StoryList: View {
    @ObservedObject var viewModel: StoryListViewModel
    @State private var showAlert = false
    
    var body: some View {
        if let pages = viewModel.pages?.pages {
            NavigationStack {
                VStack {
                    StoryListPages(
                        stories: pages.flatMap { $0.users },
                        seenIds: viewModel.seenIds,
                        onTap: { user in
                            viewModel.detailsView(user: user)
                        }, onLoadMore: { viewModel.loadMore()
                        }
                    )
                }
                .padding()
                .onAppear {
                    viewModel.onAppear()
                }
                .alert(isPresented: .constant(viewModel.error != nil), error: viewModel.error) { _ in
                      Button("OK") {
                          viewModel.didDismissErrorAlert()
                      }
                    } message: { error in
                        Text(error.localizedDescription)
                    }
            }
        } else {
            Text("Loading...")
        }
    }
}

struct StoryListPages: View {
    let stories: [User]
    let seenIds: [Int]
    var onTap: ((User) -> StoryView)
    var onLoadMore: (() -> Void)
    var body: some View {
        List {
            ForEach(stories) { story in
                NavigationLink(value: story) {
                    StoryInfoCell(
                        user: story,
                        seen: seenIds.contains(story.id)
                    )
                }
            }
            Button("Load more") {
                onLoadMore()
            }
            
        }.navigationDestination(for: User.self) { user in
            onTap(user)
        }
        .background(Color.white)
    }
}

struct StoryInfoCell: View {
    let user: User
    let seen: Bool
    var body: some View {
        HStack(spacing: 12){
            AsyncImage(url: URL(string: user.profilePictureUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .modifier(RoundedImage(size: 128))
            VStack (alignment: .leading) {
                Text(user.name)
                    
                if seen {
                    Image(systemName: "checkmark.seal.text.page")
                }
            }.foregroundColor(seen ? Color.green : Color.black)
            Spacer()
        }
        
    }
}

struct CellBackground: ViewModifier {
    let seen: Bool
    func body(content: Content) -> some View {
        if seen {
            content
                .background(Rectangle()
                    .fill(.gray))
        }
        
    }
}

struct RoundedImage: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .clipShape(.rect(cornerRadius: 25))
    }
}

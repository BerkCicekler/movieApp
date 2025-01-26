//
//  searchView.swift
//  movieApp
//
//  Created by Berk Çiçekler on 20.01.2025.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false){
            CustomSearchFieldView(
                placeHolderText: "Search",
                text: $viewModel.searchText)
            .onSubmit {
                Task {
                    await viewModel.onSubmit()
                }
            }
            SearchList()
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(22)
            .background(AppColorConstants.BackgroundColor)
            .environment(viewModel)
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
    
}

fileprivate struct SearchList: View {
    
    @Environment(SearchViewModel.self) private var VM
    
    var body: some View {
        LazyVStack{
            ForEach(VM.movies) {
                MovieHolderView(movie: $0)
            }
            if VM.totalPages != 0 {
                PageControllerView()
            }
            
        }
    }
    

}

fileprivate struct PageControllerView: View {
    
    @Environment(SearchViewModel.self) var vm
    
    @State private var isAlertOn: Bool = false
    @State private var text = ""
    
    let asim: Int32 = 5
    
    fileprivate func changePage(page: Int32) {
        Task {
            await vm.changePage(page: page)
        }
    }
    
    var body: some View {
        HStack {
            Button {
                changePage(page: vm.page - 1)
            } label: {
                Image(systemName: "chevron.left")
            }
            Text("\(vm.page)")
                .padding(6)
                .background(.teal, in: RoundedRectangle(cornerRadius: 18))
            ForEach(vm.page + 1 ..< vm.page + asim, id:\.self) { page in
                if (page < vm.totalPages) {
                    Text("\(page)")
                        .onTapGesture {
                        changePage(page: page)
                    }
                }
            }
            if(vm.page + asim < vm.totalPages) {
                Text("...").onTapGesture {
                    isAlertOn.toggle()
                }.alert("Page Input", isPresented: $isAlertOn, actions: {
                    TextField("Page Number", text: $text).keyboardType(.numberPad)
                    Button("Search", action: {
                        changePage(page: Int32(text) ?? 0)
                    })
                })
                Text("\(vm.totalPages)").onTapGesture {
                    changePage(page: vm.totalPages)
                }
            }
            Button {
                changePage(page: vm.page + 1)
            } label: {
                Image(systemName: "chevron.right")
            }
            }.foregroundStyle(.white).font(.title2)
        }
    
    }

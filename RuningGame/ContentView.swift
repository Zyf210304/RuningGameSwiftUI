//
//  ContentView.swift
//  RuningGame
//
//  Created by 亚飞 on 2021/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}


struct  Home : View {
    
    @State var search = ""
    @State var Index = 0
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body : some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack {
                
                HStack {
                    
                    Text("Game Store")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                TextField("Search", text: self.$search)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 25)
                
                
                TabView(selection: self.$Index){
                    
                    ForEach(0...5, id:\.self) { index in
                        Image("album")
                            .resizable()
                            //adding animation...
                            .frame(height: self.Index == index ?  230 : 200)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .tag(index)
                    }
                    
                }
                .frame(height: 230)
                .padding(.top, 25)
                .tabViewStyle(PageTabViewStyle())
                .animation(.easeOut)
                
                
                HStack {
                    Text("Popular")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.easeOut) {
                            if self.columns.count == 2 {
                                self.columns.removeLast()
                            }
                            else {
                                self.columns.append(GridItem(.flexible(), spacing: 15))
                                
                            }
                        }
                        
                        
                        
                    }, label: {
                        Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    })
                }
                .padding(.horizontal)
                .padding(.top, 25)
                
                
                LazyVGrid(columns: self.columns,  spacing: 25, content: {
                    
                    ForEach(data) { game in
                        
                        GrideView(game: game, colums: self.$columns)
                        
                    }
                    
                })
                .padding([.horizontal, .top])
                
            }
            .padding(.vertical)
            
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
        
    }
    
}

struct GrideView : View {
    
    var game : Game
    
    @Binding var colums : [GridItem]
    @Namespace var namespace
        
    var body: some View {
        
        VStack {
            
            if self.colums.count == 2 {
                
                VStack(spacing: 15) {
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                        Image(game.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
                            .cornerRadius(10)
                            
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.red)
                                .padding(.all, 10)
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.all, 10)
                        
                    })
                    .matchedGeometryEffect(id: "image", in: self.namespace)
                    
                    
                    
                    Text(game.name)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .matchedGeometryEffect(id: "name", in: self.namespace)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Buy now")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                    .matchedGeometryEffect(id: "buy", in: self.namespace)
                    
                }
                
            }
            else {
                
                VStack(spacing: 15) {
                    
                    
                    HStack(spacing: 15) {
                        
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                            Image(game.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width - 45) / 2,height: 250)
                                .cornerRadius(10)
                                
                            
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.red)
                                    .padding(.all, 10)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            })
                            .padding(.all, 10)
                            
                        })
                        .matchedGeometryEffect(id: "image", in: self.namespace)
                        
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text(game.name)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .matchedGeometryEffect(id: "name", in: self.namespace)

                            HStack(spacing: 10) {
                                
                                ForEach(1...5, id: \.self) { rating in
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(self.game.rating >= rating ? .yellow : .gray)
                                    
                                }
                                
                                Spacer()
                            }
                            
                            
                            Button(action: {

                            }, label: {
                                Text("Buy now")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 25)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            })
                            .padding(.top, 10)
                            .matchedGeometryEffect(id: "buy", in: self.namespace)
//                            Spacer(minLength: 0)
                            
                        })
                        
                    }
                    
                    
                }
                .padding(.trailing)
                .background(Color.white)
                .cornerRadius(15)
                
                
                
            }
            
        }
        
        
       
    }
    
    
}





struct Game : Identifiable {
    
    var id : Int
    var name : String
    var image : String
    var rating : Int
    
    
}

var data = [

    Game(id: 0, name: "Game1", image: "album", rating: 3),
    Game(id: 1, name: "Game2", image: "album", rating: 5),
    Game(id: 2, name: "Game3", image: "album", rating: 5),
    Game(id: 3, name: "Game4", image: "album", rating: 1),
    Game(id: 4, name: "Game5", image: "album", rating: 2),
    Game(id: 5, name: "Game6", image: "album", rating: 4),
    Game(id: 6, name: "Game7", image: "album", rating: 3),
    Game(id: 7, name: "Game8", image: "album", rating: 2)
    
]

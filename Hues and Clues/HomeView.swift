//
//  HomeView.swift
//  Hues and Clues
//
//  Created by Daniel Coyle on 3/20/24.

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    @State var showSheet = false
    @State var audioPlayer:AVAudioPlayer?
    
    var body: some View {
        
        NavigationStack{
            VStack {
                HStack{
                    Text("Guess")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                    
                    Text("This")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                    Text("Color")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.purple)
                }
                .padding(.top, 20)
                
                Spacer()
                
                NavigationLink {
                    PlayView()
                        .onAppear(perform: {
                            audioPlayer?.pause()
                        })
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 110))
                            .foregroundStyle(Color(red: 12/255, green: 234/255, blue: 17/255))
                        Text("Start")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
                
                Button {
                    showSheet = true
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 110))
                            .foregroundStyle(Color(red: 255/255, green: 165/255, blue: 0/255))
                        Text("How to Play")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding()
            .background(Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
            .sheet(isPresented: $showSheet, content: {
                InformationView()
            })
            .onAppear(perform: {
                playMusic()
                audioPlayer?.play()
            })
        }
        
    }
    
    func playMusic() {
        // Load the audio file
        if let soundURL = Bundle.main.url(forResource: "TheFatRat_Unity", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = -1 // Play infinitely
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
    }
    
}

#Preview {
    HomeView()
}

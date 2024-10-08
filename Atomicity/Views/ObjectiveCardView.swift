//
//  ObjectiveCardView.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI

struct ObjectiveCardView: View {
   
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                
                HStack {
                    VStack(alignment: .leading) {
                       
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.blue)
                                    .frame(height: 40)
                                HStack {
                                    Text("⌛︎Active")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .fontDesign(.serif)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 7)
                                    Spacer( )
                                }
                            }
                        }
                        HStack{
                            Spacer()
                            Image(systemName: "scope")
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .fontDesign(.serif)
                                .foregroundColor(.blue)
                                  Text("WRMG Weld Excellence")
                                .font(.system(size: 10))
                                .fontDesign(.serif)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Spacer()
                        }   .padding(.horizontal)
                        Text("Calibrate All Miller Weld Equipment")
                            .font(.title3)
                            .fontDesign(.serif)
                            .foregroundColor(.indigo)
                            .padding(.horizontal, 7)
                            .padding(.top, 1)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip .")
                            .font(.subheadline)
                            .fontDesign(.serif)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 7)
                            .padding(.top, 10)
                            .padding(.bottom, 40)
                            .lineLimit(2)
                        HStack {
                            Text("Due:")
                                .fontDesign(.serif)
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Image(systemName: "calendar")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.trailing, -20)
                             
                            Text("27 October 2024")
                                .fontDesign(.serif)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 7)
                                .padding(.trailing, 10)
                            ZStack{
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.primary)
                                    .frame(width: 57, height: 27)
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.red.opacity(0.9))
                                    .frame(width: 55, height: 25)
                                Text("Ozark")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .fontDesign(.serif)
                                    .foregroundStyle(.white)
                                
                                    
                            }
                        }
                    }.padding(.horizontal, 10)
                    Spacer( )
                }
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color.gray.opacity(0.35))
                    .frame(height: 240)
                
                
            }
        }.padding(.horizontal, 1)
    }
}

#Preview {
    ObjectiveCardView()
}

//
//  File.swift
//  HelloWorld
//
//  Created by Frank Chu on 4/7/22.
//

import Foundation
import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack(spacing: 4) {
                                Text("Insights")
                                    .font(Font.custom("Arial Rounded MT Bold", size: 35))
                                    .fontWeight(.bold)
                                    .font(.largeTitle)
                                
                                Text("+")
                                    .padding(.bottom, 10)
                                    .font(.largeTitle)
                            }
                            Text("iCloud 同步，还有未来更多新功能。")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                        Image(systemName: "plus.magnifyingglass")
                            .resizable()
                            .shadow(radius: 10)
                            .frame(width: 60, height: 60)
                            .padding()
                    }
                    
                    NavigationLink("了解更多") {
                        
                    }
                    
                }
                .foregroundColor(.white)
                .listRowBackground(Color.blue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Section {
                    NavigationLink {
                        
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "bell.badge")
                                .foregroundColor(.blue)
                                .font(.title3)
                            Text("通知")
                        }
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "square.stack.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                            Text("获取 App 信息")
                        }
                    
                    }
                }
            }
            .navigationTitle("设置")
        }
    }
}

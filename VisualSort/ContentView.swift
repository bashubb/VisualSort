//
//  ContentView.swift
//  VisualSort
//
//  Created by HubertMac on 25/01/2024.
//

import SwiftUI

struct ContentView: View {
    enum SortTypes: String, CaseIterable {
        case bubble = "Bubble Sort"
        case insertion = "Insertion Sort"
        case quick = "Quick Sort"
    }
    
    
    @State private var values = (1...100).map(SortValue.init).shuffled()
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var timerSpeed = 0.1
    
    @State private var insertionSortPosition = 1
    
    @State private var sortFunction = SortTypes.bubble
    
    var body: some View {
        VStack(spacing:20) {
            Text("VisualSort")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    ForEach(values) { value in
                        Rectangle()
                            .fill(value.color)
                            .frame(width: proxy.size.width * 0.01, height: proxy.size.height * Double(value.id) / 100)
                    }
                }
            }
            .padding(.bottom)
            
            Picker("Sort Type", selection: $sortFunction) {
                ForEach(SortTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            
            HStack(spacing: 20) {
                LabeledContent("Speed") {
                    Slider(value: $timerSpeed, in: 0...1)
                }
                
                Button("Step", action: step)
                
                Button("Shuffle") {
                    withAnimation {
                        values.shuffle()
                        insertionSortPosition = 1
                    }
                }
                
            }
            
            
        }
        .preferredColorScheme(.dark)
        .padding()
        .onReceive(timer) { _ in
            step()
        }
        .onChange(of: timerSpeed) {
            timer.upstream.connect().cancel()
            
            if timerSpeed != 0 {
                timer = Timer.publish(every: timerSpeed, on: .main, in: .common).autoconnect()
            }
        }
    }
    func step() {
        withAnimation{
            switch sortFunction {
            case .bubble:
                values.bubbleSort()
            case .insertion:
                insertionSortPosition = values.insertionSort(startPosition: insertionSortPosition)
            case .quick:
                values.quickSort()
            }
        }
    }
}

#Preview {
    ContentView()
}

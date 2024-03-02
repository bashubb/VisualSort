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
    @State private var sortPosition = 1
    @State private var sortFunction = SortTypes.bubble
    @State private var animationSpeed = 1.0
    
    @State private var expandMoreInfo = false
    @State private var showInfo = false
    
    var body: some View {
        ZStack {
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
                    LabeledContent("Delay") {
                        Slider(value: $timerSpeed, in: 0.01...1)
                    }
                    
                    Button("Step", action: step)
                    Button("Shuffle") {
                        withAnimation {
                            values.shuffle()
                            sortPosition = 1
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
                if timerSpeed == 1 || sortFunction.rawValue == "Quick Sort"{
                    timer.upstream.connect().cancel()
                } else {
                    timer = Timer.publish(every: timerSpeed, on: .main, in: .common).autoconnect()
                }
            }
            .onChange(of: sortFunction) {
                sortPosition = 1
                if sortFunction.rawValue == "Quick Sort"{
                    animationSpeed = 0.2
                } else {
                    animationSpeed = 1
                }
            }
            
            // Info Card
            GeometryReader { gp in
                VStack(spacing: 15) {
                    Spacer()
                    VStack(spacing: 10) {
                        Text("More info about sorting here")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).opacity(0.2))
                    .padding(.horizontal)
                    .opacity(showInfo ? 1 : 0)
                    
                    HStack {
                        Spacer()
                        Text("More info")
                        Image(systemName: "info.circle")
                            .padding(.horizontal)
                    }
                    .font(.title)
                }
                .padding(.bottom, 3)
                .background(RoundedRectangle(cornerRadius:20).fill(Color.yellow).shadow(radius: 8))
                .foregroundStyle(.black)
                .offset(x: expandMoreInfo ? -15 : -gp.size.width + 15,
                        y: expandMoreInfo ? -15 : -gp.size.height + 40)
                .onTapGesture{
                    withAnimation {
                        expandMoreInfo.toggle()
                    }
                    withAnimation(.default.delay(0.5)) {
                        showInfo.toggle()
                    }
                }
            }
        }
        
    }
    
    func step() {
        withAnimation(.easeInOut.speed(animationSpeed)) {
            switch sortFunction {
            case .bubble:
                sortPosition = values.bubbleSort(startPosition: sortPosition)
            case .insertion:
                sortPosition = values.insertionSort(startPosition: sortPosition)
            case .quick:
                values.quickSort()
            }
        }
    }
    
}

#Preview {
    ContentView()
}

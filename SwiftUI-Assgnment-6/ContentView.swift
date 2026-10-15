//
//  ContentView.swift
//  SwiftUI-Assgnment-6
//
//  Created by NikoDanelia on 14/10/2026.
//

import SwiftUI

////GCD
struct ContentView: View {
    @State private var progress: Double = 0.0
        @State private var isReady: Bool = false
        @State private var sliderValue: Double = 50.0

        var body: some View {
            VStack(spacing: 30) {
                // სლაიდერი მოძრაობს თუ არა ლოდინის დროს
                VStack {
                    Text("სლაიდერი: \(Int(sliderValue))")
                    Slider(value: $sliderValue, in: 0...100)
                }
                .padding()

                // პროგრესბარი
                ProgressView(value: progress, total: 1.0)
                    .padding()

                // სტატუსი
                if isReady {
                    Text("✅ მზადაა")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                } else {
                    Text("იტვირთება...")
                        .foregroundColor(.gray)
                }

                // ჩამოტვირთვის ღილაკი
                Button("ჩამოტვირთვა (GCD)") {
                    startDownloadWithGCD()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }

        func startDownloadWithGCD() {
            // თავიდან ვასუფთავებთ
            progress = 0.0
            isReady = false

            // 1-ლი წამი
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.progress = 1.0 / 3.0
            }

            // მე-2 წამი (
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.progress = 2.0 / 3.0
            }

            // მე-3 წამი
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.progress = 1.0
                self.isReady = true
            }
        }
    }
    
    
    
    
////async/await
//@State private var progress: Double = 0.0
//    @State private var isReady: Bool = false
//    @State private var sliderValue: Double = 50.0
//
//    var body: some View {
//        VStack(spacing: 30) {
//            // სლაიდერი
//            VStack {
//                Text("სლაიდერი: \(Int(sliderValue))")
//                Slider(value: $sliderValue, in: 0...100)
//            }
//            .padding()
//
//            // პროგრესბარი
//            ProgressView(value: progress, total: 1.0)
//                .padding()
//
//            // სტატუსი
//            if isReady {
//                Text("✅ მზადაა")
//                    .font(.title2)
//                    .bold()
//                    .foregroundColor(.green)
//            } else {
//                Text("იტვირთება...")
//                    .foregroundColor(.gray)
//            }
//
//            // ჩამოტვირთვის ღილაკი Async/Await
//            Button("ჩამოტვირთვა (Async/Await)") {
//                Task {
//                    await startDownloadAsync()
//                }
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .padding()
//    }
//
//    func startDownloadAsync() async {
//        // ვასუფთავებთ თავიდან მთავარ ეკრანზე
//        await MainActor.run {
//            progress = 0.0
//            isReady = false
//        }
//
//        // 3 ნაბიჯი თითო წამიანი ინტერვალით
//        for i in 1...3 {
//            do {
//                // 1 წამის ლოდინი
//                try await Task.sleep(nanoseconds: 1_000_000_000)
//                
//                // UI-ს განახლება მთავარ ეკრანზე
//                await MainActor.run {
//                    self.progress = Double(i) / 3.0
//                    if i == 3 {
//                        self.isReady = true
//                    }
//                }
//            } catch {
//                print("Task cancelled")
//            }
//        }
//    }
//}


#Preview {
    ContentView()
}

//
//  ProgressView.swift
//  MoodTracker
//
//  Created by GaneshBalaraju on 14/06/25.
//

// In ProgressView.swift

import SwiftUI
import Charts

struct MoodDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let mood: String
    var moodValue: Int {
        switch mood {
        case "Happy": return 5
        case "Calm": return 4
        case "Okay": return 3
        case "Anxious": return 2
        case "Sad": return 1
        default: return 0
        }
    }
}

struct ProgressView: View {
    let moodHistory: [MoodDataPoint] = [
        .init(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, mood: "Okay"),
        .init(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, mood: "Happy"),
        .init(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, mood: "Calm"),
        .init(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, mood: "Anxious"),
        .init(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, mood: "Okay"),
        .init(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, mood: "Sad"),
        .init(date: Date(), mood: "Happy")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Journey")
                        .font(.custom("Lato-Bold", size: 34))
                        .padding([.top, .horizontal])

                    VStack(alignment: .leading) {
                        Text("Last 7 Days")
                            .font(.custom("Lato-Bold", size: 20))
                        
                        Chart {
                            ForEach(moodHistory) { dataPoint in
                                LineMark(x: .value("Date", dataPoint.date, unit: .day), y: .value("Mood", dataPoint.moodValue))
                                    .foregroundStyle(Color(red: 0.3, green: 0.5, blue: 0.6))
                                PointMark(x: .value("Date", dataPoint.date, unit: .day), y: .value("Mood", dataPoint.moodValue))
                                    .annotation(position: .top) { Text(moodIcon(dataPoint.mood)).font(.caption) }
                                    .foregroundStyle(Color(red: 0.4, green: 0.6, blue: 0.5))
                            }
                        }
                        .chartYAxis {
                            AxisMarks(values: [1, 2, 3, 4, 5]) { value in
                                AxisGridLine()
                                AxisTick()
                                AxisValueLabel { Text(moodString(for: value.as(Int.self) ?? 0)).font(.custom("Lato-Regular", size: 10)) }
                            }
                        }
                        .chartXAxis(.hidden)
                        .frame(height: 200)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)

                    HStack {
                        InsightCard(title: "Check-in Streak", value: "7 Days", icon: "flame.fill")
                        InsightCard(title: "Common Mood", value: "Okay", icon: "smiley.fill")
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Mindfulness Practices").font(.custom("Lato-Bold", size: 20)).padding(.horizontal)
                        PracticeCard(title: "Mindful Breathing", description: "A 5-minute guided session to find your center.", icon: "wind")
                    }
                }
            }
            .background(Color(red: 0.96, green: 0.96, blue: 0.95).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
    
    func moodIcon(_ mood: String) -> String {
        switch mood { case "Happy": return "😊"; case "Calm": return "😌"; case "Okay": return "😐"; case "Anxious": return "😟"; case "Sad": return "😢"; default: return "❓" }
    }
    
    func moodString(for value: Int) -> String {
        switch value { case 5: return "Happy"; case 4: return "Calm"; case 3: return "Okay"; case 2: return "Anxious"; case 1: return "Sad"; default: return "" }
    }
}

struct InsightCard: View {
    var title: String, value: String, icon: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { Image(systemName: icon).foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5)); Text(title).font(.custom("Lato-Regular", size: 16)) }
            Text(value).font(.custom("Lato-Bold", size: 22))
        }
        .padding().frame(maxWidth: .infinity, alignment: .leading).background(Color.white).cornerRadius(15).shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct PracticeCard: View {
    var title: String, description: String, icon: String
    var body: some View {
        HStack {
            Image(systemName: icon).font(.title).foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.6)).frame(width: 50)
            VStack(alignment: .leading) {
                Text(title).font(.custom("Lato-Bold", size: 17))
                Text(description).font(.custom("Lato-Regular", size: 14)).foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.gray.opacity(0.5))
        }
        .padding().background(Color.white).cornerRadius(15).shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4).padding(.horizontal)
    }
}

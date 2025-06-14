//
//  MoodLogView.swift
//  MoodTracker
//
//  Created by GaneshBalaraju on 14/06/25.
//

// In MoodLogView.swift

import SwiftUI

struct MoodLogView: View {
    @State private var selectedMood: String?
    @State private var journalEntry = "Write about your feelings..."
    @State private var showAffirmation = false
    
    let moods = ["Happy", "Calm", "Okay", "Anxious", "Sad"]

    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.97, blue: 0.95).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 25) {
                    Text("How are you feeling today?")
                        .font(.custom("Lato-Bold", size: 28))
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                        .padding(.top, 40)

                    HStack(spacing: 15) {
                        ForEach(moods, id: \.self) { mood in
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedMood = mood
                                }
                            }) {
                                VStack {
                                    Image(systemName: moodIcon(mood))
                                        .font(.system(size: 30))
                                    Text(mood)
                                        .font(.custom("Lato-Regular", size: 14))
                                }
                                .padding()
                                .frame(width: 70, height: 70)
                                .background(selectedMood == mood ? Color(red: 0.6, green: 0.8, blue: 0.7) : Color.white)
                                .foregroundColor(selectedMood == mood ? .white : .gray)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                                .scaleEffect(selectedMood == mood ? 1.1 : 1.0)
                            }
                        }
                    }

                    TextEditor(text: $journalEntry)
                        .font(.custom("Lato-Regular", size: 17))
                        .foregroundColor(journalEntry == "Write about your feelings..." ? .gray.opacity(0.6) : .black)
                        .padding()
                        .frame(height: 200)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            if journalEntry == "Write about your feelings..." {
                                journalEntry = ""
                            }
                        }

                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            showAffirmation = true
                        }
                    }) {
                        Text("Save Entry")
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.3, green: 0.5, blue: 0.6))
                            .cornerRadius(12)
                            .shadow(color: Color(red: 0.3, green: 0.5, blue: 0.6).opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            if showAffirmation {
                PositiveAffirmationView(show: $showAffirmation)
            }
        }
    }
    
    func moodIcon(_ mood: String) -> String {
        switch mood {
        case "Happy": return "face.smiling"
        case "Calm": return "leaf"
        case "Okay": return "face.neutral"
        case "Anxious": return "wind"
        case "Sad": return "face.dashed"
        default: return "questionmark"
        }
    }
}

struct PositiveAffirmationView: View {
    @Binding var show: Bool
    let affirmations = ["Your feelings are valid.", "You are doing your best.", "Be kind to yourself today."]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5))
                Text(affirmations.randomElement()!)
                    .font(.custom("Lato-Regular", size: 16))
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(red: 0.2, green: 0.2, blue: 0.3).opacity(0.9))
            .cornerRadius(20)
            .shadow(radius: 10)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        show = false
                    }
                }
            }
            Spacer().frame(height: 50)
        }
    }
}

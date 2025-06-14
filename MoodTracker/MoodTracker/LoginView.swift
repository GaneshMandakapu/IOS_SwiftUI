//
//  LoginView.swift
//  MoodTracker
//
//  Created by GaneshBalaraju on 14/06/25.
//


import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var onLoginSuccess: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.95).ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()
                Text("Welcome Back")
                    .font(.custom("Lato-Bold", size: 34))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                Text("Log in to continue your journey.")
                    .font(.custom("Lato-Regular", size: 18))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.custom("Lato-Regular", size: 16))
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.custom("Lato-Regular", size: 16))
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal, 30)

                Button(action: {
                    onLoginSuccess() // Trigger the login success callback
                }) {
                    Text("Login")
                        .font(.custom("Lato-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.3, green: 0.5, blue: 0.6))
                        .cornerRadius(12)
                        .shadow(color: Color(red: 0.3, green: 0.5, blue: 0.6).opacity(0.4), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 30)

                Spacer()

                HStack {
                    Text("Don't have an account?")
                        .font(.custom("Lato-Regular", size: 16))
                    Button("Sign Up") {}
                        .font(.custom("Lato-Bold", size: 16))
                        .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.5))
                }
                .padding(.bottom, 40)
            }
        }
    }
}

//
//  ProfileView.swift
//  HelpOnTheGo
//
//  Created by Matthew Fraser on 2023-04-15.
//

import SwiftUI

struct Review: Identifiable {
    let id: String
    let rating: Int
    let review: String
}

struct ProfileView: View {
    // For demonstration purposes, you can use hardcoded data.
    // When connecting to the backend, replace these with actual data.
    let bio = "A short bio about the user."
    let name = "Evan Surtel"
    let completed = 10
    let location = "San Francisco, CA"
    let userType = "Regular"
    let rating = 4.5
    let reviews = [
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience."),
        Review(id: "user123", rating: 5, review: "Great service!"),
        Review(id: "user456", rating: 4, review: "Good experience.")
    ]
    let contact = (phone: "123-456-7890", email: "user@example.com")
    @State private var showReviews = false
    @State private var numberOfReviewsToShow = 10
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    profileImage
                    Spacer()
                }
                nameSection
                locationSection
                
                VStack(spacing: 5) {
                    Divider().background(Color.gray)
                    HStack {
                        helpedEvents
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Divider()
                        
                        ratingSection
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    Divider().background(Color.gray)
                }
                bioSection
                
                
                userTypeSection
                
                contactSection
                reviewsSection
                Spacer()
            }
            .padding()
        }
    }
    
    var profileImage: some View {
        // Profile image
        Image("profile-placeholder")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
    
    var nameSection: some View {
        Text("\(name)")
            .font(.custom("Futura-Heavy", size: 36)) // Set custom font and size
            .foregroundColor(.black) // Set text color
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
        
    }
    
    var bioSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Bio")
                .font(.title)
                .fontWeight(.bold)
            Text(bio)
        }
    }
    
    var helpedEvents: some View {
        VStack{
            Text("\(completed)")
                .font(.system(size: 28, weight: .semibold))
            
            Text("Helped Events")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.gray)
        }
    }
    var ratingSection: some View {
        VStack{
            Text("\(String(format: "%.1f", rating))")
                .font(.system(size: 28, weight: .semibold))
            
            Text("Rating")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.gray)
        }
    }
    
    var locationSection: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .foregroundColor(.red)
            Text("\(location)")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color.gray) // Change the color to light gray
        }
        .frame(maxWidth: .infinity)
    }
    
    var userTypeSection: some View {
        Text("User type: \(userType)")
            .font(.title2)
            .fontWeight(.bold)
    }
    
    
    
    var contactSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Contact")
                .font(.title)
                .fontWeight(.bold)
            Text("Phone: \(contact.phone)")
            Text("Email: \(contact.email)")
        }
    }
    
    var reviewsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Reviews")
                .font(.title)
                .fontWeight(.bold)
            
            Button(action: {
                showReviews.toggle()
            }) {
                Text(showReviews ? "Hide Reviews" : "Show Reviews")
                    .font(.callout)
                    .foregroundColor(.blue)
            }
            
            if showReviews {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(reviews.prefix(numberOfReviewsToShow)) { review in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Rating: \(review.rating)")
                                .fontWeight(.bold)
                            Text(review.review)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    if numberOfReviewsToShow < reviews.count {
                        Button(action: {
                            numberOfReviewsToShow += 10
                        }) {
                            Text("Show More")
                                .font(.callout)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
}





struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

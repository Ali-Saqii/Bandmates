//
//  editProfileView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var pvm: ProfileViewModel
    let user: userModel?
    @State private var showImagePicker = false
    @State private var newProfileImage : UIImage? = nil
    @State private var newFullName = ""
    @State private var newUserName = ""
    @State private var newEmail = ""
    @State private var newBio = ""
    @Environment(\.dismiss) var dissmiss
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack(spacing:20) {
                headerImagePickerView
                inputFieldsView
                    .padding(.horizontal)
                inputBioView
                buttonView(action: {updateProfile()}, buttonText: "Save Changes", height: 50)
                    .padding()
                Spacer()
            }
        }.onChange(of: pvm.isUpdated, { _, newValue in
            if newValue {
                newFullName = ""
                newUserName = ""
                dissmiss()
                pvm.isUpdated = false
            }
        })
        .onAppear(perform: {
            getNames()
        })
        .overlay(content: {
            if pvm.isLoading {
                Rectangle()
                    .fill(.textfieldcolor.opacity(0.5))
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView()
                            .tint(Color.background)
                    }
            }
        })
        .navigationTitle("edit profile".capitalized)
            .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $newProfileImage)
        }
    }
    
    private func getNames() {
        guard let user = user  else {return}
        newFullName = user.fullName
        newUserName = user.userName
        newBio = user.Bio
    }
    private func updateProfile() {
        pvm.updateProfile(username: newFullName,displayName: newUserName,description: newBio,avatar: newProfileImage)
    }
}
extension EditProfileView {
    private var headerImagePickerView: some View {
        VStack(spacing: 7) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .strokeBorder(
                        Color.background,
                        lineWidth: 2
                    )
                    .frame(width: 100, height: 100)
                    .overlay(
                        
                        Group {
                            if let image = newProfileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                            } else {
                                if let user = pvm.user {
                                    AsyncImage(url: URL(string: user.profileImage.hasPrefix("http")
                                                        ? user.profileImage
                                                        : "http://localhost:3000/\(user.profileImage)")) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } else if phase.error != nil {
                                            Text(user.fullName.initials ?? "")
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.white)
                                                .background(
                                                    Circle()
                                                        .fill(.secondary.opacity(0.6))
                                                )
                                        } else if user.profileImage.isEmpty {
                                            Text(user.fullName.initials  ?? "")
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.white)
                                                .background(
                                                    Circle()
                                                        .fill(.secondary.opacity(0.6))
                                                )
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .clipShape(Circle())
                                }
                                
                            }
                        }
                    )
                Button(action: { showImagePicker = true }) {
                    ZStack {
                        Circle()
                            .fill(Color.background)
                            .frame(width: 23, height: 23)
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .offset(x: 0, y: -3)
            }
        }
    }
    
    private var inputFieldsView: some View {
        VStack(spacing: 20) {
            if let user = user {
                InputField(label: "Full Name", placeholder: "Edit Your Name" ,text: $newFullName)
                InputField(label: "Username", placeholder: "Edit UserName" ,text: $newUserName)
                    .overlay(alignment:.trailing) {
                        Image(systemName: newUserName.contains("@") ? "checkmark" : "exclamationmark")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 18, height: 18)
                            .background(
                                Circle()
                                    .fill(
                                        newUserName.contains("@") ? Color.background : Color .red
                                    )
                            )
                            .offset(x: -10, y: 10)
                    }
                InputField(label: "Email", placeholder: user.email ,text: $newEmail)
            }
        }
    }
    private var inputBioView: some View {
        VStack(alignment: .leading,spacing: 20) {
            if let user = user {
                Text("Bio")
                    .padding(.leading)
                reusabletextEditor(text: $newBio, PlaceHolder: user.Bio, height: 150, color: .textfieldcolor.opacity(0.4))
            }
        }
    }
}
#Preview {
    EditProfileView( user: DeveloperPreview.instance.profile)
        .environmentObject(ProfileViewModel())
}

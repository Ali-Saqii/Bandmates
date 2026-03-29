//
//  editProfileView.swift
//  Bandmates
//
//  Created by Mac mini on 29/03/2026.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var pvm: ProfileViewModel
    let user: userModel
    @State private var showImagePicker = false
    @State private var newProfileImage : UIImage? = nil
    @State private var newFullName = ""
    @State private var newUserName = ""
    @State private var newEmail = ""
    @State private var newBio = ""
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack(spacing:20) {
                headerImagePickerView
                inputFieldsView
                    .padding(.horizontal)
                inputBioView
                buttonView(action: {}, buttonText: "Save Changes", height: 50)
                    .padding()
                Spacer()
            }
        }.onAppear(perform: {
            getNames()
        })
        .navigationTitle("edit profile".capitalized)
            .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $newProfileImage)
        }
    }
    
    private func getNames() {
        newFullName = user.fullName
        newUserName = user.userName
        newBio = user.Bio
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
                                AsyncImage(url: URL(string: pvm.user.profileImage)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } else if phase.error != nil {
                                        Text(pvm.user.fullName.initials ?? "")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                            .background(
                                                Circle()
                                                    .fill(.secondary.opacity(0.6))
                                            )
                                    } else if pvm.user.profileImage.isEmpty {
                                        Text(pvm.user.fullName.initials  ?? "")
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
    
    private var inputBioView: some View {
        VStack(alignment: .leading,spacing: 20) {
            Text("Bio")
                .padding(.leading)
            reusabletextEditor(text: $newBio, PlaceHolder: user.Bio, height: 150, color: .textfieldcolor.opacity(0.4))
        }
    }
}
#Preview {
    EditProfileView( user: DeveloperPreview.instance.profile)
        .environmentObject(ProfileViewModel())
}

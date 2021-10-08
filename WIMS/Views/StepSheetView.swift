//
//  StepSheetView.swift
//  WIMS
//
//  Created by Thiago Medeiros on 07/10/21.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingwithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }
}

struct StepSheetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var stepData: StepViewModel
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    init(stepData: StepViewModel) {
        self.stepData = stepData
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if let image = stepData.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 231)
                } else {
                    Rectangle()
                        .fill(Color(UIColor.systemGray3))
                        .frame(maxHeight: 231)
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                }
                
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .frame(width: 24, height: 24)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "chevron.right")
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal, 16)
                .font(.title2)
                .foregroundColor(.black)
                .wimsShadow()
            }
            
            VStack {
                TextField("Nome ", text: $stepData.name)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Toggle(isOn: $stepData.isDone) {
                    Text("Concluído")
                }
                
                TextEditor(text: $stepData.notes)
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .background(Color.white)
            .clipShape(RoundedCorners(corners: [.topLeft, .topRight], radius: 16))
            .offset(y: -16)
        }
        .navigationBarHidden(true)
        .background(Color.white)
        .onDisappear {
            self.stepData.writeData(context: viewContext)
            self.stepData.reset()
        }
        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $stepData.image)
        }
    }
    
    func loadImage() {
        guard let inputImage = stepData.image else { return }
        image = Image(uiImage: inputImage)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct StepSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StepSheetView(stepData: StepViewModel())
    }
}

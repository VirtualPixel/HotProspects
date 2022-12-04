//
//  MeView.swift
//  HotProspects
//
//  Created by Justin Wells on 12/1/22.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    //@State private var name: String //= "Anonymous"
    //@State private var emailAddress: String //= "you@yoursite.com"
    
    @EnvironmentObject var me: User
    @State private var qrCode = UIImage()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $me.me.name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email Address", text: $me.me.emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your Code")
            .onAppear(perform: updateCode)
            .onChange(of: me.me.name) { _ in updateCode() }
            .onChange(of: me.me.emailAddress) { _ in updateCode() }
        }
    }
        
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\($me.me.name)\n\($me.me.emailAddress)")
        me.save()
    }
}
/*
struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
*/

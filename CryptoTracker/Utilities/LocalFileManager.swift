//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 9.07.2022.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    private init() { }
    
    // MARK: FOLDER WHERE WE SAVE IMAGE, URL for folder
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    //MARK: Create folder if needed
   private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
               try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating  FolderName: \(folderName)  directory: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: URL FOR we save image
    private func getUrlForImage(imageName: String,folderName: String) -> URL? {
        guard let folderUrl = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
    // MARK: SAVE IMAGE FUNC
    func saveImage(image: UIImage,imageName: String, folderName: String) {
      // create folder
        createFolderIfNeeded(folderName: folderName)
      // get path for image
        guard  let data = image.pngData(),
              let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else { return }
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving ImageName:\(imageName) image:\(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String,folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)else {
                  return nil
                }
        return UIImage(contentsOfFile: url.path)
    }
    
    
}

//
//  EmployeeImageCache.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/10/22.
//

import UIKit

struct EmployeeImageCache {
    
    static let shared = EmployeeImageCache()
    private static let subpath = "/employee_images"

    /// Returns the disk cache directory URL, normally we'd want to log a failure here if it failed, not fatal error.
    /// - Returns: disk cache directory URL
    private func getCacheDirectory() -> URL {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to locate cache directory")
        }
        return directory.appendingPathExtension(Self.subpath)
    }
    
    /// Store an image to disk if it doesn't already exist.
    /// Silently fail if something goes wrong, normally we'd want to log this
    /// - Parameters:
    ///   - image: the UIImage to store
    ///   - key: the key used for the image path
    func store(image: UIImage, forKey key: String) {
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            print("Image unable to be compressed")
            return
        }
        
        do {
            try imageData.write(to: getCacheDirectory().appendingPathComponent("\(key)"))
        } catch let error {
            print("Error saving file: \(error)")
        }
    }
    
    
    /// Returns an image if it exists in the disk cache
    /// - Parameter key: the key to lookup our image data
    /// - Returns: an optional UIImage
    func getImage(forKey key: String) -> UIImage? {
        let imageUrl = getCacheDirectory().appendingPathComponent("\(key)")
        let image = UIImage(contentsOfFile: imageUrl.path)
        return image
    }
    
    /// Create sub directory for images if it doesn't already exist
    func setupCache() {
        let path = getCacheDirectory().path
        if FileManager.default.fileExists(atPath: path) {
            return
        } else {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch let error{
                print("Error creating directory: \(error)")
            }
        }
    }
    
    /// Clears our cache by deleting the subdirecrory and the images within it
    func clearCache() {
        let path = getCacheDirectory().path
        guard FileManager.default.fileExists(atPath: path) else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: getCacheDirectory())
        } catch let error {
            print("Error removing directory: \(error)")
        }
    }
}

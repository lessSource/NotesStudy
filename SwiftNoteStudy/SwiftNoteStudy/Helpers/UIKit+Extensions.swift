//
//  UIKit+Extensions.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2018/12/17.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit
import Photos

extension UIImagePickerController {
    typealias Handle = (_ success: Bool, _ message: String) -> ()
    // 相机权限
    func cameraHandle(_ handle: @escaping Handle) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("不支持相机")
            return
        }
        sourceType = .camera
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized:
            handle(true, "允许授权")
        case .denied:
            handle(false, "拒绝授权")
        case .restricted:
            handle(false, "限制授权")
        case .notDetermined:
            requestCameraOrMicrophoneAuthorization(.video, handle: handle)
        }
    }
    
    // 相册权限
    func photoAlbumHandle(_ handle: @escaping Handle) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("不支持相册")
            return
        }
        sourceType = .photoLibrary
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .authorized:
            handle(true, "允许授权")
        case .denied:
            handle(false, "拒绝授权")
        case .restricted:
            handle(false, "限制授权")
        case .notDetermined:
            requestPhotoAuthorization(handle)
        }
    }
    
    // 相册授权
    fileprivate func requestPhotoAuthorization(_ handle: @escaping Handle) {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.sync {
                if status == .authorized {
                    handle(true, "允许授权")
                }else {
                    handle(true, "用户拒绝授权")
                }
            }
        }
    }
    
    // 麦克风、相机授权
    fileprivate func requestCameraOrMicrophoneAuthorization(_ mediaType: AVMediaType, handle: @escaping Handle) {
        AVCaptureDevice.requestAccess(for: mediaType) { (granted) in
            if granted {
                handle(true, "允许授权")
            }else {
                handle(true, "用户拒绝授权")
            }
        }
    }
    
}

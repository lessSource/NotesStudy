//
//  CameraQRViewController.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2018/12/24.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import Photos

class CameraQRViewController: BaseSwiftViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "相机"
        // Do any additional setup after loading the view.
        setupCamera()
    }
    
    // MARK:- private
    fileprivate func setupCamera() {
        // 获取摄像设备
        guard let device = AVCaptureDevice.default(for: .video) else {
            return
        }
        let input: AVCaptureDeviceInput
        // 创建输入流
        do {
            try input = AVCaptureDeviceInput(device: device)
        } catch {
            return
        }
        // 创建输出流
        let output = AVCaptureMetadataOutput()
        // 设置代理 在主线程里刷新
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 初始化链接对象（回话对象）
        // 高质量采集率
        session.canSetSessionPreset(.high)
        // 添加回话输入
        if session.canAddInput(input) {
            session.addInput(input)
        }
        // 添加回话输出
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        // 设置输出数据类型 需要将元数据输出添加到回话后 才能指定元数据类型
        // 设置扫描支持的编码格式
        output.metadataObjectTypes = [.qr,.code128,.ean8,.ean13]
        
        // 实例化预览图层
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        // 将图层插入当前视图
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // 启动回话
        session.startRunning()
    }

    
    fileprivate lazy var session: AVCaptureSession = {
        let seccion = AVCaptureSession()
        return seccion
    }()
    
    fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        return previewLayer
    }()
    
    fileprivate var device: AVCaptureDevice?
}


extension CameraQRViewController: AVCaptureMetadataOutputObjectsDelegate {
    
}

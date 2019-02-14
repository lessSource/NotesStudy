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
    /** 扫描内容的X值 */
    fileprivate let scanContent_X: CGFloat = 93
    /** 扫描内容的Y值 */
    fileprivate let scanContent_Y: CGFloat = 100
    /** 扫描内容宽高*/
    fileprivate let scanContent_h_w: CGFloat = 189
    /** 扫描内容外部View的alpha值 */
    fileprivate let scanBorderOutsideViewAlpha: CGFloat = 0.5
    /** 扫描动画线(冲击波) 的高度 */
    fileprivate let scanninglineHeight: CGFloat = 6
    /** 二维码冲击波动画时间 */
    fileprivate let SGQRCodeScanningLineAnimation: TimeInterval = 2
    /** 是否结束扫描 */
    fileprivate var isEndScanning: Bool = false

    
    fileprivate lazy var session: AVCaptureSession = {
        let seccion = AVCaptureSession()
        return seccion
    }()
    
    fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        return previewLayer
    }()
    
    fileprivate var device: AVCaptureDevice?
    
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
        
        // 设置扫描范围（每一个取值0~1，以屏幕右上角为坐标原点）
        let imageRect = CGRect(x: scanContent_X, y: scanContent_Y, width: scanContent_h_w, height: scanContent_h_w)
        output.rectOfInterest = converToMetadataOutputRectOfInterestForRect(imageRect)
        
        // 启动回话
        session.startRunning()
    }

    // 创建扫描view
    fileprivate func scanTheExternalView() {
        let scanZomeBack = UIImageView(frame: CGRect(x: scanContent_X, y: scanContent_Y, width: scanContent_h_w, height: scanContent_h_w))
        scanZomeBack.image = UIImage(named: "")
        scanZomeBack.backgroundColor = UIColor.clear
        view.addSubview(scanZomeBack)
        
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor.withHex(hexString: "#000000", alpha: scanBorderOutsideViewAlpha)
        view.layer.addSublayer(backgroundView.layer)
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = kCAFillRuleEvenOdd // 奇偶显示规则
        let basicPath = UIBezierPath(rect: view.frame) // 底层
        let maskPath = UIBezierPath(rect: scanZomeBack.frame) // 显示层
        basicPath.append(maskPath) // 重叠
        
        maskLayer.path = basicPath.cgPath
        backgroundView.layer.mask = maskLayer
        
    }
    
    // 确认扫描区域
    fileprivate func converToMetadataOutputRectOfInterestForRect(_ cropRect: CGRect) -> CGRect {
        let size = previewLayer.bounds.size
        let p1: CGFloat = size.height/size.width
        var p2: CGFloat = 0.0
        if session.sessionPreset == .high {
            p2 = 1920/1080
        }
        if previewLayer.videoGravity == .resizeAspectFill {
            if p1 < p2 {
                let fixHeight: CGFloat = size.width * p2
                let fixPadding: CGFloat = (fixHeight - size.height)/2
                return CGRect(x: (cropRect.origin.x + fixPadding)/fixHeight, y: (size.width - (cropRect.size.width + cropRect.origin.x))/size.width, width: cropRect.size.height/fixHeight, height: cropRect.size.width/size.width)
            }else {
                let fixWidth: CGFloat = size.height * (1/p2)
                let fixPadding: CGFloat = (fixWidth - size.width)/2
                return CGRect(x: cropRect.origin.y / size.height, y: (size.width - (cropRect.size.width + cropRect.origin.x) + fixPadding)/fixWidth, width: cropRect.size.height/size.height, height: cropRect.size.width/fixWidth)
            }
        }
        return CGRect(x: 0, y: 0, width: 1, height: 1)
    }
    
    
    // 扫描成功后声音
    fileprivate func systemSound() {
        var soundID: SystemSoundID = 0
        let strSoundFile: String = Bundle.main.path(forResource: "noticeMusic", ofType: "wav") ?? ""
        let soundleURL = URL(fileURLWithPath: strSoundFile)
        AudioServicesCreateSystemSoundID(soundleURL as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
}


extension CameraQRViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let metadaObject: AVMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            let metaStr = metadaObject.stringValue ?? ""
            print(metaStr)
        }
    }
    
    
    
}

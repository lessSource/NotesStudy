//
//  HomeSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import SnapKit
import Then

class HomeSwiftViewController: BaseSwiftViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "首页"
        
        let stack = Stack()
        stack.push(object: "ddd" as AnyObject)
        print(stack.peek ?? "")
        
        let nameLabel = UILabel().then {
            $0.text = "ddd"
            
        }
        view.addSubview(nameLabel)
        
        
        // Do any additional setup after loading the view.
        let imageView  = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.addSubview(imageView)
        
//        imageView.image =
        
        let url = URL.init(fileURLWithPath: "http://www.objc.io/images/covers/16.jpg")
        let data = try? Data.init(contentsOf: url)
        
        var image = CIImage()
        if let _ = data {
            image = CIImage(data: data!)!
        }
        
        
//        let blurRadius = 5.0
//        let overlayColor = UIColor.red.withAlphaComponent(0.2)
//        let blurredImage = self.blur(radius: blurRadius)(image)
//        let orerlaidImage = self.colorOverlay(color: overlayColor)(blurredImage)
//
//        imageView.image = convertCIImageToUIImage(ciImage: orerlaidImage)
    }
    
    /// CIImage转UIImage相对简单，直接使用UIImage的初始化方法即可
    func convertCIImageToUIImage(ciImage:CIImage) -> UIImage {
        let uiImage = UIImage.init(ciImage: ciImage)
        // 注意！！！这里的uiImage的uiImage.cgImage 是nil
        _ = uiImage.cgImage
        // 注意！！！上面的cgImage是nil，原因如下，官方解释
        // returns underlying CGImageRef or nil if CIImage based
        return uiImage
    }
    
    typealias Filter = (CIImage) -> CIImage
    
//    infix operator >>> { associativity left }
//
//    func >>> () -> <#return type#> {
//        <#function body#>
//    }
    
//    func myFilter(/* parameters */) -> Filter{}
    
    func blur(radius: Double) -> Filter {
        return { image in
            let parameters = [kCIInputRadiusKey: radius, kCIInputImageKey: image] as [String : Any]
            guard let filter = CIFilter.init(name: "CIGaussianBlur", withInputParameters: parameters) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
        
    }
    
    func colorGenerator(color: UIColor) -> Filter {
        return { _ in
            let c = CIColor.init(color: color)
            let parameters = [kCIInputColorKey: c]
            guard let filter = CIFilter.init(name: "CIConstantColorGenerator", withInputParameters: parameters) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
    }
    
    //合成滤镜
    func compositeSourceOver(overlay: CIImage) -> Filter {
        return { image in
            let parameters = [kCIInputBackgroundImageKey: image, kCIInputImageKey: overlay]
            guard let filter = CIFilter.init(name: "CISourceOverComposition", withInputParameters: parameters) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            let cropRect = image.extent
            return outputImage.cropped(to: cropRect)
            
        }
        
    }
    
    func colorOverlay(color: UIColor) -> Filter {
        return { image in
            let overlay = self.colorOverlay(color: color)(image)
            return self.compositeSourceOver(overlay: overlay)(image)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class Stack {
    var stack: [AnyObject] = []
    var isEmpty: Bool { return stack.isEmpty }
    var peek: AnyObject? { return stack.last }
    
    init() {
        stack = [AnyObject]()
    }
    
    func push(object: AnyObject) {
        stack.append(object)
    }
    
    func pop() -> AnyObject? {
        if !isEmpty {
            return stack.removeLast()
        }else {
            return nil
        }
    }
    
}

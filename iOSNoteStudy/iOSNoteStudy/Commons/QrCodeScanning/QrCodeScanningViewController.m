//
//  QrCodeScanningViewController.m
//  Community
//
//  Created by Lj on 2017/8/11.
//  Copyright © 2017年 lj. All rights reserved.
//



/** 扫描内容的X值 */
#define scanContent_X kScreenWidth * 0.15
/** 扫描内容的Y值 */
#define scanContent_Y kScreenHeight * 0.20
/** 扫描内容宽高*/
#define scanContent_h_w kScreenWidth - 2 *scanContent_X

/** 扫描内容外部View的alpha值 */
static CGFloat const scanBorderOutsideViewAlpha = 0.4;
/** 扫描动画线(冲击波) 的高度 */
static CGFloat const scanninglineHeight = 12;
/** 二维码冲击波动画时间 */
static CGFloat const SGQRCodeScanningLineAnimation = 0.05;

#import "QrCodeScanningViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UIImage+QRCodeImage.h"

@interface QrCodeScanningViewController()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) UIImageView *scanningLineImage;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation QrCodeScanningViewController

#pragma mark - Lazy
- (UIImageView *)scanningLineImage {
    if (_scanningLineImage == nil) {
        _scanningLineImage = [[UIImageView alloc]init];
        _scanningLineImage.image = [UIImage imageNamed:@"scan_Line"];
        _scanningLineImage.frame = CGRectMake(scanContent_X + 40, scanContent_Y,  scanContent_h_w - 80, scanninglineHeight);
    }
    return _scanningLineImage;
}

- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _imagePickerController.allowsEditing = true;
    }
    return _imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"二维码扫描";
    [self initView];
}

#pragma mark - initView
- (void)initView {
    [self _setupScanningQRCode];
    [self _addTimer];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(albumClick)];
    barbutton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barbutton;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取文件类型
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //关闭相册
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([type isEqualToString:@"public.image"]) {
        //编辑后的图片
        UIImage *image = [UIImage imageSizeWithScreenImage:info[UIImagePickerControllerOriginalImage]];
        if (image) {
            //初始化扫描仪，设置识别类型和识别质量
            CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
            //扫描获取的特征组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
            if (features.count != 0) {
                //获取扫描结果
                CIQRCodeFeature *feature = [features objectAtIndex:0];
                NSString *scannedResult = feature.messageString;
                [self _systemSound];
                if (self.QRDelegate && [self.QRDelegate respondsToSelector:@selector(QrCodeScanningViewStr:)]) {
                    [self.QRDelegate QrCodeScanningViewStr:scannedResult];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [[LSAlertUtil alertManager]showPromptInfo:@"没有获取到图片中的二维码"];
            }
        }
    }else {
        [[LSAlertUtil alertManager]showPromptInfo:@"您所选的不是图片"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮事件
//执行定时器方法
- (void)timeAction {
    __block CGRect frame = _scanningLineImage.frame;
    static BOOL flag = YES;
    if (flag) {
        frame.origin.y = scanContent_Y;
        flag = NO;
        [UIView animateWithDuration:SGQRCodeScanningLineAnimation animations:^{
            frame.origin.y += 5;
            self->_scanningLineImage.frame = frame;
        } completion:nil];
    }else {
        if (_scanningLineImage.frame.origin.y >= scanContent_Y) {
            CGFloat scanContent_MaxY = scanContent_Y + kScreenWidth - 2 * scanContent_X;
            if (_scanningLineImage.frame.origin.y >= scanContent_MaxY - 10) {
                frame.origin.y = scanContent_Y;
                _scanningLineImage.frame = frame;
                flag = YES;
            } else {
                [UIView animateWithDuration:SGQRCodeScanningLineAnimation animations:^{
                    frame.origin.y += 5;
                    _scanningLineImage.frame = frame;
                } completion:nil];
            }
        } else {
            flag = !flag;
        }
    }
}

- (void)flashButtonClick {
    
}

//打开手电筒
- (void)floodlightClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self _hasToTurnofftheLights];
}

//打开相册
- (void)albumClick {
    if ([self _isCanUsePhotos]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            //判断是否支持相片库
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //判断是否支持图库
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else {
            return;
        }
        [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
    }else {
        [[LSAlertUtil alertManager]showPromptInfo:@"您没有访问相册权限，请到设置的设置"];
    }
}

#pragma mark -
- (void)_setupScanningQRCode {
    [self _scanTheExternalView];
    //获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描范围（每一个取值0～1，以屏幕又上角为坐标原点）
    CGRect mImageRect = CGRectMake(scanContent_X , scanContent_Y, scanContent_h_w, scanContent_h_w);
    CGRect scanCrop = [self _getScanCrop:mImageRect readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化连接对象（会话对象）
    self.session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    //添加会话输入
    [_session addInput:input];
    //添加会话输出
    [_session addOutput:output];
    //设置输出数据类型，需要讲元数据输出添加到会话后，才能指定元数据类型，否则会报错
    //设置扫码支持的编码格式（如下设置条形码和二维码的兼容）
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    //实例化预览图层，传递_session是为了告诉图层将要显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    //将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    //启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        [self _removeTimer];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        [self _systemSound];
        if (self.QRDelegate && [self.QRDelegate respondsToSelector:@selector(QrCodeScanningViewStr:)]) {
            [self.QRDelegate QrCodeScanningViewStr:stringValue];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//确定扫描区域
- (CGRect)_getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds {
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds) - CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds) - CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    return CGRectMake(x, y, width, height);
}

//扫描线
- (void)_loopDrawLine {
    //扫描动画添加
    [self.view.layer addSublayer:self.scanningLineImage.layer];
}

//扫描View的创建
- (void)_scanTheExternalView {
    //扫描内容的创建
    UIImage *hbImage = [UIImage imageNamed:@"scanning"];
    UIImageView *scanZomeBack = [[UIImageView alloc]init];
    scanZomeBack.userInteractionEnabled = YES;
    scanZomeBack.backgroundColor = [UIColor clearColor];
    //    scanZomeBack.layer.borderColor = [UIColor whiteColor].CGColor;
    //    scanZomeBack.layer.borderWidth = 2.5;
    scanZomeBack.image = hbImage;
    //添加一个背景
    CGRect mImageRect = CGRectMake(scanContent_X , scanContent_Y, scanContent_h_w, scanContent_h_w);
//    [SGSettingUtil addTapGestureInView:scanZomeBack addTarget:self action:@selector(flashButtonClick) withTag:77767];
    [scanZomeBack setFrame:mImageRect];
    [self.view addSubview:scanZomeBack];
    
    //顶部layer的创建
    CALayer *top_layer = [[CALayer alloc]init];
    CGFloat top_layerX = 0;
    CGFloat top_layerY = 0;
    CGFloat top_layerW = kScreenWidth;
    CGFloat top_layerH = scanContent_Y;
    top_layer.frame = CGRectMake(top_layerX, top_layerY, top_layerW, top_layerH);
    top_layer.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.view.layer addSublayer:top_layer];
    
    // 左侧layer的创建
    CALayer *left_layer = [[CALayer alloc] init];
    CGFloat left_layerX = 0;
    CGFloat left_layerY = scanContent_Y;
    CGFloat left_layerW = scanContent_X;
    CGFloat left_layerH = scanContent_h_w;
    left_layer.frame = CGRectMake(left_layerX, left_layerY, left_layerW, left_layerH);
    left_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.view.layer addSublayer:left_layer];
    
    // 右侧layer的创建
    CALayer *right_layer = [[CALayer alloc] init];
    CGFloat right_layerX = CGRectGetMaxX(scanZomeBack.frame);
    CGFloat right_layerY = scanContent_Y;
    CGFloat right_layerW = scanContent_X;
    CGFloat right_layerH = scanContent_h_w;
    right_layer.frame = CGRectMake(right_layerX, right_layerY, right_layerW, right_layerH);
    right_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.view.layer addSublayer:right_layer];
    
    // 下面layer的创建
    CALayer *bottom_layer = [[CALayer alloc] init];
    CGFloat bottom_layerX = 0;
    CGFloat bottom_layerY = CGRectGetMaxY(scanZomeBack.frame);
    CGFloat bottom_layerW = kScreenWidth;
    CGFloat bottom_layerH = self.view.frame.size.height - scanContent_Y;
    bottom_layer.frame = CGRectMake(bottom_layerX, bottom_layerY, bottom_layerW, bottom_layerH);
    bottom_layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha].CGColor;
    [self.view.layer addSublayer:bottom_layer];

    //提示文字
    UILabel *promptingLabel = [[UILabel alloc]init];
    CGFloat promptingLabelX = 15;
    CGFloat promptingLabelY = CGRectGetMaxY(scanZomeBack.frame) + 5;
    CGFloat promptingLabelW = kScreenWidth - 30;
    CGFloat promptingLabelH = 25;
    promptingLabel.frame = CGRectMake(promptingLabelX, promptingLabelY, promptingLabelW, promptingLabelH);
    promptingLabel.textColor = UIColor.mainColor;
    promptingLabel.font = LSFont_Size_12;
    promptingLabel.textAlignment = NSTextAlignmentCenter;
    promptingLabel.text = @"将二维码放入框内，即可自动扫描";
    [self.view addSubview:promptingLabel];
    
    UIButton *floodlight = [[UIButton alloc]init];
    CGFloat floodlightX = kScreenWidth/2 - 50;
    CGFloat floodlightY = CGRectGetMaxY(scanZomeBack.frame) + 40;
    CGFloat floodlightW = 100;
    CGFloat floodlightH = 70;
    floodlight.frame = CGRectMake(floodlightX, floodlightY, floodlightW, floodlightH);
    floodlight.titleLabel.font = LSFont_Size_12;
    [floodlight setImage:[UIImage imageNamed:@"floodlight"] forState:UIControlStateNormal];
    [floodlight setImage:[UIImage imageNamed:@"floodlight_select"] forState:UIControlStateSelected];
    [floodlight setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 20, 35)];
    [floodlight setTitleEdgeInsets:UIEdgeInsetsMake(55, - 60, 0, 0)];
    floodlight.titleLabel.textAlignment = NSTextAlignmentCenter;
    [floodlight setTitle:@"打开手电筒" forState:UIControlStateNormal];
    [floodlight setTitle:@"关闭手电筒" forState:UIControlStateSelected];
    [floodlight addTarget:self action:@selector(floodlightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:floodlight];
}

//扫描成功后声音
- (void)_systemSound {
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle]pathForResource:@"noticeMusic" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:strSoundFile]), &soundID);
    AudioServicesPlaySystemSound(soundID);
}

//照明灯
- (void)_hasToTurnofftheLights {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([_device hasTorch]) {
        [_device lockForConfiguration:nil];
        if (_device.torchMode == AVCaptureTorchModeOn) {
            [_device setTorchMode:AVCaptureTorchModeOff];
        }else if (_device.torchMode == AVCaptureTorchModeOff) {
            [_device setTorchMode:AVCaptureTorchModeOn];
        }else if (_device.torchMode == AVCaptureTorchModeAuto) {
            [_device setTorchMode:AVCaptureTorchModeOff];
        }
        [_device unlockForConfiguration];
    }else {
        [[LSAlertUtil alertManager]showPromptInfo:@"该设备不支持照明灯"];
    }
}

#pragma mark 添加定时器
- (void)_addTimer {
    [self _loopDrawLine];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:SGQRCodeScanningLineAnimation target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//移除定时器
- (void)_removeTimer {
    [self.timer invalidate];
    self.timer = nil;
    [self.scanningLineImage removeFromSuperview];
    self.scanningLineImage = nil;
}

//判断是否有获取相册权限
- (BOOL)_isCanUsePhotos {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}


@end

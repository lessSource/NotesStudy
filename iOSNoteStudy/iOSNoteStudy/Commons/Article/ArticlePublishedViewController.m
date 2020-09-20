//
//  ArticlePublishedViewController.m
//  Behing
//
//  Created by Lj on 2018/7/6.
//  Copyright © 2018年 lj. All rights reserved.
//

#define App_Frame_Height    [[UIScreen mainScreen] bounds].size.height
#define App_Frame_Width     [[UIScreen mainScreen] bounds].size.width

#define rectStatus  [[UIApplication sharedApplication] statusBarFrame]
#define kStatusHeight           (rectStatus.size.height)
#define kTopBarHeight           (44.f)
#define kNavbarAndStatusBar     (kStatusHeight + kTopBarHeight)
#define kBottomBarHeight        (kDevice_Is_iPhone_X ? 83.f : 49.f)
#define kBarHeight              (kDevice_Is_iPhone_X ? 34.f : 0.f)

//#define SizeScale ((App_Frame_Width > 320.00) ? App_Frame_Width/375.00 : 1)

// 颜色方法RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// 颜色方法HEX
#define ColorWithHexStr(Hex) [UIColor colorWithHexString:Hex]
#define ColorWithHexStrAlpha(Hex,A) [UIColor colorWithHexString:Hex alpha:A]


#pragma mark - 背景色
#define Main_BackColor ColorWithHexStr(@"#F5F5F5")

#pragma mark - 主色
#define Main_Color  ColorWithHexStr(@"#49DD82")

#pragma mark - 点缀色
#define Ornament_Color  ColorWithHexStr(@"#FD7837")

#define FDC72F_Color ColorWithHexStr(@"#FDC72F")

#pragma mark - 分割线
#define Dividing_Line_Color  ColorWithHexStr(@"#EEEEEE")

//边框颜色
#define Border_Line_Color  ColorWithHexStr(@"#CCCCCC")

//背景色
#define Back_Color_F6F6FA ColorWithHexStr(@"#F6F6FA")
#define Back_Color_FCFCFC ColorWithHexStr(@"#FCFCFC")


//button点击时字体的颜色
#define Button_SelectColor ColorWithHexStrAlpha(@"#49DD82",0.8)
//button未点击时字体的颜色
#define Button_NormalColor ColorWithHexStr(@"#49DD82")

//button不能点击时颜色
#define Button_NoSelect_Color ColorWithHexStr(@"#C7C7CD")

//tabBar点击时字体的颜色
#define TabBar_SelectColor Main_Color
//tabBar未点击时字体的颜色
#define TabBar_NormalColor ColorWithHexStr(@"#9B99A9")
//tabBar背景颜色
#define TabBar_TintColor [UIColor whiteColor]

typedef NS_ENUM(NSInteger, PictureSourceUseType) {
    PictureSourceUseCoverType = 0,           //封面
    PictureSourceUseContentPhotoType,        //内容（图库）
    PictureSourceUseContentCameraType,       //内容（相机）

};

static CGFloat const PictureViewHeight = 50;

#import "ArticlePublishedViewController.h"
#import "LineView.h"
#import "ArticleContentTextView.h"
#import "UITextView+Placeholder.h"
#import "NSTextAttachment+LMText.h"
#import "UIFont+LMText.h"
#import "LMParagraphConfig.h"
#import "LMTextHTMLParser.h"
#import "UIView+Layout.h"
#import "UIImage+Local.h"
#import "PermissionsObject.h"
#import "BHSingleLabel.h"
#import "PopUpViewObjeect.h"
#import "ArticleSourceView.h"
//#import <Iqb>

@interface ArticlePublishedViewController () <UITextViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PopUpProtocol>
@property (nonatomic, strong) UIView *pictureView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *coverPageImage;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, assign) PictureSourceUseType pictureUseType;
@property (nonatomic, strong) BHSingleLabel *coverPageLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) LineView *titleLine;
@property (nonatomic, strong) ArticleContentTextView *contentTextView;
@property (nonatomic, strong) LMParagraphConfig *currentParagraphConfig;
@property (nonatomic, assign) NSRange lastSelectRange;
@property (nonatomic, assign) BOOL keepCurrentTextStyle;
@property (nonatomic, strong) ArticleSourceView *articleSourceView;

@end

@implementation ArticlePublishedViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发美文";
    self.view.backgroundColor = [UIColor whiteColor];
    [self _keyboardlisten];
//    [self initNavBarBackBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    rightItem.tintColor = UIColor.mainColor;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height - PictureViewHeight - kNavbarAndStatusBar - kBarHeight)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self setPictureView];
    [self initView];
}

- (void)setPictureView {
    self.pictureView = [[UIView alloc]initWithFrame:CGRectMake(0, App_Frame_Height - PictureViewHeight - kBarHeight - kNavbarAndStatusBar, App_Frame_Width, PictureViewHeight)];
    self.pictureView.backgroundColor = Main_BackColor;
    [self.view addSubview:self.pictureView];
    
    UIButton *pictureButton = [[UIButton alloc]init];
    [pictureButton addTarget:self action:@selector(pictureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [pictureButton setImage:[UIImage imageNamed:@"相册"] forState:UIControlStateNormal];
//    pictureButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.pictureView addSubview:pictureButton];
    [pictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pictureView);
        make.right.equalTo(self.pictureView.mas_right).offset(- 5);
        make.top.equalTo(self.pictureView);
        make.width.equalTo(pictureButton.mas_height).multipliedBy(1.0);
    }];
    
    UIButton *cameraButton = [[UIButton alloc]init];
    [cameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton setImage:[UIImage imageNamed:@"拍摄"] forState:UIControlStateNormal];
//    cameraButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.pictureView addSubview:cameraButton];
    [cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pictureView);
        make.right.equalTo(pictureButton.mas_left).offset(- 10);
        make.top.equalTo(self.pictureView);
        make.height.equalTo(cameraButton.mas_width).multipliedBy(1.0);
    }];
}

- (void)initView {
    self.coverPageImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, App_Frame_Width - 30, 150)];
    self.coverPageImage.backgroundColor = Main_BackColor;
    self.coverPageImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagGestureClick)];
    [self.coverPageImage addGestureRecognizer:tagGesture];
    [self.scrollView addSubview:self.coverPageImage];
    
    self.coverPageLabel = [[BHSingleLabel alloc]init];
    self.coverPageLabel.text_bold(18).text = @"添加封面";
    self.coverPageLabel.textColor = Main_Color;
    [self.coverPageImage addSubview:self.coverPageLabel];
    [self.coverPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.coverPageImage);
    }];
    
    self.promptLabel = [[UILabel alloc]init];
    self.promptLabel.text = @"精致的封面为美文增加人气";
    self.promptLabel.font = BHFont_Size_12;
    self.promptLabel.textColor = Text_Color_DDDDDD;
    [self.coverPageImage addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverPageLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self.coverPageImage);
    }];
    
    self.titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.coverPageImage.frame) + 10, App_Frame_Width - 30, 50)];
    self.titleTextField.delegate = self;
    self.titleTextField.font = [UIFont boldSystemFontOfSize:18];
    self.titleTextField.placeholder = @"请输入标题";
    self.titleTextField.adjustsFontSizeToFitWidth = YES;
    [self.scrollView addSubview:self.titleTextField];
    
    self.titleLine = [[LineView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleTextField.frame), App_Frame_Width - 30, 1)];
    self.titleLine.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8" alpha:1.0];
    [self.scrollView addSubview:self.titleLine];
    
    self.contentTextView = [[ArticleContentTextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLine.frame) + 10, App_Frame_Width - 30, CGRectGetMidY(self.pictureView.frame) - CGRectGetMaxY(self.titleLine.frame) - 10)];
    self.contentTextView.scrollEnabled = NO;
    self.contentTextView.delegate = self;
    self.contentTextView.placeholder = @"正文";
    self.contentTextView.font = BHFont_Size_15;
    self.contentTextView.textColor = Text_Color_444444;
    [self.scrollView addSubview:self.contentTextView];
    
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self _textChanegContent:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (self.lastSelectRange.location != textView.selectedRange.location) {
        if (self.keepCurrentTextStyle) {
            //如果当前的内容为空，TextView会自动使用上一行的typingAttributes, 所以在删除内容时，保持typingAttributes不变
            [self _updateTextStyleTypingAttributes];
            [self _updateParagraphTypingAttributes];
            self.keepCurrentTextStyle = NO;
        }else {
            [self _updateTextStyleForSelection];
            [self _updateParagraphTypingAttributes];
        }
        
    }
    self.lastSelectRange = textView.selectedRange;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location == 0 && range.length == 0 && text.length == 0) {
        self.currentParagraphConfig.indentLevel = 0;
        [self _updateParagraphTypingAttributes];
    }
    self.lastSelectRange = NSMakeRange(range.location + text.length - range.length, 0);
    if (text.length == 0 && range.length > 0) {
        self.keepCurrentTextStyle = YES;
    }
//    NSArray *arr = [UITextInputMode activeInputModes];
//    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        if (self.pictureUseType == PictureSourceUseCoverType) {
            if (editedImage) {
                [self _getCoverImage:editedImage];
            }else {
                [[BHAlertUtil alertManager]showPromptInfo:@"获取图片失败"];
            }
        }else {
            if (image) {
                [self _getContentImage:image];
            }else {
                [[BHAlertUtil alertManager]showPromptInfo:@"获取图片失败"];
            }
        }
    }else {
        [[BHAlertUtil alertManager]showPromptInfo:@"您所选的不是图片"];
    }
}

#pragma mark - PopUpProtocol
- (void)selectPopUpView:(UIView *)popUpView data:(id)data {
    [self _getContentRequest:data];
}

#pragma mark - Event
//发布
- (void)rightItemClick {
    if (!self.coverPageLabel.hidden) {
        [[BHAlertUtil alertManager] showPromptInfo:@"请选择封面"];
    }else if ([BHSettingUtil dataAndStringIsNull:self.titleTextField.text]) {
        [[BHAlertUtil alertManager] showPromptInfo:@"请输入标题"];
    }else if ([BHSettingUtil dataAndStringIsNull:self.contentTextView.text]) {
        [[BHAlertUtil alertManager] showPromptInfo:@"请输入内容"];
    }else {
        [self.view endEditing:YES];
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.articleSourceView direction:PopUpViewDirectionTypeCenter];
    }
}

//封面
- (void)tagGestureClick {
    [self _permissions:PictureSourceUseCoverType];
}

//图片
- (void)pictureButtonClick:(UIButton *)sender {
    [self _permissions:PictureSourceUseContentPhotoType];
}
//相机
- (void)cameraButtonClick:(UIButton *)sender {
    [self _permissions:PictureSourceUseContentCameraType];
}

//键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndH = value.CGRectValue.size.height;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.pictureView.tz_top = (App_Frame_Height - keyBoardEndH - PictureViewHeight - kBarHeight - kNavbarAndStatusBar);
        self.scrollView.tz_height = (App_Frame_Height - PictureViewHeight - kNavbarAndStatusBar - kBarHeight - keyBoardEndH);
    }];
}

//当键盘退出
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.pictureView.tz_top = (App_Frame_Height - PictureViewHeight - kBarHeight - kNavbarAndStatusBar);
        self.scrollView.tz_height = (App_Frame_Height - PictureViewHeight - kNavbarAndStatusBar - kBarHeight);
        NSLog(@"---%f--",kNavbarAndStatusBar);
        
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - Private
- (void)_keyboardlisten {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//封面
- (void)_getCoverImage:(UIImage *)image {
    UIImage *modifyImage = [UIImage imageResize:image resizeTo:CGSizeZero];
    self.coverPageImage.tz_height = modifyImage.size.height;
    self.coverPageImage.image = modifyImage;
    self.coverPageLabel.hidden = self.promptLabel.hidden = YES;
    self.titleTextField.tz_top = CGRectGetMaxY(self.coverPageImage.frame) + 10;
    self.titleLine.tz_top = CGRectGetMaxY(self.titleTextField.frame);
    self.contentTextView.tz_top = CGRectGetMaxY(self.titleLine.frame) + 10;
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.contentTextView.frame) + 20);
}

//内容图片
- (void)_getContentImage:(UIImage *)image {
    float actualWidth = image.size.width * image.scale;
    float boundsWidth = App_Frame_Width - 30;
    float compressionQuality = boundsWidth / actualWidth;
    if (compressionQuality > 1) {
        compressionQuality = 1;
    }
    NSData *degradedImageData = UIImageJPEGRepresentation(image, compressionQuality);
    UIImage *degradedImage = [UIImage imageWithData:degradedImageData];
    NSTextAttachment *attachment = [self _insertImage:degradedImage];
    [self.contentTextView resignFirstResponder];
    [self.contentTextView scrollRangeToVisible:self.lastSelectRange];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *filePath = [documentDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[NSDate date].description]];
        NSData *originImageData = UIImagePNGRepresentation(image);
        if ([originImageData writeToFile:filePath.path atomically:YES]) {
            attachment.attachmentType = LMTextAttachmentTypeImage;
            attachment.userInfo = filePath.absoluteString;
        }
    });
}


- (NSTextAttachment *)_insertImage:(UIImage *)image {
    CGFloat width = CGRectGetWidth(self.contentTextView.frame);
    NSTextAttachment *textAttachment = [NSTextAttachment attachmentWithImage:image width:width];
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"\n"];
    [attributedString insertAttributedString:attachmentString atIndex:0];
    
    if (self.lastSelectRange.location != 0 && ![[self.contentTextView.text substringWithRange:NSMakeRange(self.lastSelectRange.location - 1, 1)] isEqualToString:@"\n"]) {
        //上一个字符不为"\n"则图片前添加一个换行 且 不是第一个位置
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    }
    [attributedString addAttributes:self.contentTextView.typingAttributes range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.paragraphSpacingBefore = 8.f;
    paragraphStyle.paragraphSpacing = 8.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.contentTextView.attributedText];
    [attributedText replaceCharactersInRange:self.lastSelectRange withAttributedString:attributedString];
    self.contentTextView.allowsEditingTextAttributes = YES;
    self.contentTextView.attributedText = attributedText;
    self.contentTextView.allowsEditingTextAttributes = NO;
    [self _textChanegContent:self.contentTextView];
    return textAttachment;
}

- (void)_updateTextStyleTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.contentTextView.typingAttributes mutableCopy];
    typingAttributes[NSFontAttributeName] = BHFont_Size_15;
    typingAttributes[NSForegroundColorAttributeName] = Text_Color_444444;
    typingAttributes[NSUnderlineStyleAttributeName] = @(NSUnderlineStyleNone);
    self.contentTextView.typingAttributes = typingAttributes;
}

- (void)_updateParagraphTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.contentTextView.typingAttributes mutableCopy];
    typingAttributes[LMParagraphTypeName] = @(self.currentParagraphConfig.type);
    typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
    self.contentTextView.typingAttributes = typingAttributes;
}

- (void)_updateTextStyleForSelection {
    if (self.contentTextView.selectedRange.length > 0) {
        [self.contentTextView.textStorage addAttributes:self.contentTextView.typingAttributes range:self.contentTextView.selectedRange];
    }
}

- (void)_textChanegContent:(UITextView *)textView {
    NSInteger height = ceilf([textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.contentTextView.bounds), MAXFLOAT)].height);
    self.contentTextView.tz_height = height;
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.contentTextView.frame) + 20);
    [self _accordingCursor];
}

- (void)_permissions:(PictureSourceUseType)pictureUseType {
    self.pictureUseType = pictureUseType;
    if (pictureUseType != PictureSourceUseContentCameraType) {
        [[PermissionsObject shareInstance] photoAlbumPermissions:^(BOOL isSuccess, NSString *message) {
            if (isSuccess) {
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                if (pictureUseType == PictureSourceUseCoverType) {
                    self.imagePickerController.allowsEditing = true;
                }else {
                    self.imagePickerController.allowsEditing = NO;
                }
                [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
            }else {
                [[BHAlertUtil alertManager]showPromptInfo:message];
            }
        }];
    }else {
        [[PermissionsObject shareInstance] cameraOrMicrophonePermissions:^(BOOL isSuccess, NSString *message) {
            if (isSuccess && !TARGET_IPHONE_SIMULATOR) {
                [self.view endEditing:YES];
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
            }else {
                [[BHAlertUtil alertManager]showPromptInfo:message];
            }
        } mediaType:AVMediaTypeVideo];
    }
}

- (void)_accordingCursor {
//    self.contentTextView.selectedRange =
    
//    if (self.scrollView.contentSize.height > self.scrollView.tz_height) {
//        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.tz_height);
//    }
}

- (void)_getContentRequest:(NSString *)reprinted {
    [[BHAlertUtil alertManager] showLoading:nil];
    NSArray *objArr = [LMTextHTMLParser HTMLFromAttributedString:self.contentTextView.attributedText];
    NSString *contentStr = (NSString *)objArr[0][0];
    NSArray *imageArr = (NSArray *)objArr[1];
    if (imageArr.count == 0) {
        [self requestPostDoyenAdd:contentStr reprinted:reprinted];
    }else {
        NSMutableArray *uploadImagrArr = [NSMutableArray array];
        for (int i = 0; i < imageArr.count; i ++) {
            UIImage *image = [UIImage imageFromURLString:imageArr[i]];
            [uploadImagrArr addObject:image];
        }
        [PPHTTPRequest requestUploadPicMobile:^(id response, BOOL success) {
            if (success && [response isKindOfClass:[NSDictionary class]]) {
                NSString *imageUrl = response[@"image"];
                NSArray *imagrUrlArr = [imageUrl componentsSeparatedByString:@","];
                NSString *updateContentStr = contentStr;
                for (int i = 0; i < imagrUrlArr.count; i ++) {
                    updateContentStr = [updateContentStr stringByReplacingOccurrencesOfString:imageArr[i] withString:[NSString stringWithFormat:@"%@",imagrUrlArr[i]]];
                }
                [self requestPostDoyenAdd:updateContentStr reprinted:reprinted];
            }else {
                [[BHAlertUtil alertManager] hiddenLoading];
                [[BHAlertUtil alertManager] showPromptInfo:@"图片上传失败"];
            }
        } params:uploadImagrArr];
    }
}

#pragma mark - Request
- (void)requestPostDoyenAdd:(NSString *)comment reprinted:(NSString *)reprinted {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SGUserModel *userModel = [SGUserInfo getUserInfo];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:self.coverPageImage.image, nil];
    [params setObject:self.titleTextField.text forKey:@"title"];
    [params setObject:comment forKey:@"content"];
    [params setObject:[BHSettingUtil dataAndStringIsNull:userModel.Token] ? @"" : userModel.Token forKey:@"token"];
    if ([BHSettingUtil dataAndStringIsNull:reprinted]) {
        [params setObject:@"True" forKey:@"isappreciate"];
        [params setObject:@"2" forKey:@"type"];
    }else {
        [params setObject:@"false" forKey:@"isappreciate"];
        [params setObject:@"1" forKey:@"type"];
        [params setObject:reprinted forKey:@"from"];
    }
    [PPHTTPRequest requestPsotDoyenAdd:^(id response, BOOL success) {
        [[BHAlertUtil alertManager] hiddenLoading];
        if (success) {
            self.successBlock == nil ? : self.successBlock();
            [[BHAlertUtil alertManager] showPromptInfo:@"发布成功，平台会在一个工作日内审核完毕！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } params:params images:imageArray];
}

#pragma mark - Lazy
- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return _imagePickerController;
}

- (ArticleSourceView *)articleSourceView {
    if (_articleSourceView == nil) {
        _articleSourceView = [[ArticleSourceView alloc]init];
        _articleSourceView.bounds = CGRectMake(0, 0, App_Frame_Width - 60, 250);
        _articleSourceView.center = CGPointMake(App_Frame_Width/2, App_Frame_Height/2);
        _articleSourceView.delegate = self;
    }
    return _articleSourceView;
}


@end

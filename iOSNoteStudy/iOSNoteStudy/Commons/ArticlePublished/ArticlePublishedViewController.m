//
//  ArticlePublishedViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/9.
//  Copyright © 2018年 lj. All rights reserved.
//

static CGFloat const PictureViewHeight = 50;

#import "ArticlePublishedViewController.h"
#import "LSLineView.h"
#import "ArticleContentTextView.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "NSTextAttachment+LMText.h"
#import "UIFont+LMText.h"
#import "LMParagraphConfig.h"
#import "LMTextHTMLParser.h"

@interface ArticlePublishedViewController () <UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIView *pictureView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *coverPageImage;
@property (nonatomic, strong) UILabel *coverPageLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) LSLineView *titleLine;
@property (nonatomic, strong) ArticleContentTextView *contentTextView;
@property (nonatomic, strong) LMParagraphConfig *currentParagraphConfig;
@property (nonatomic, assign) NSRange lastSelectRange;
@property (nonatomic, assign) BOOL keepCurrentTextStyle;

@end

@implementation ArticlePublishedViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    rightItem.tintColor = [UIColor randomColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - PictureViewHeight - kNavbarAndStatusBar - kBarHeight)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self setPictureView];
    [self initView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

- (void)setPictureView {
    self.pictureView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - PictureViewHeight - kBarHeight - kNavbarAndStatusBar, kScreenWidth, PictureViewHeight)];
    self.pictureView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.pictureView];
    
    UIButton *pictureButton = [[UIButton alloc]init];
    [pictureButton addTarget:self action:@selector(pictureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [pictureButton setImage:[UIImage imageNamed:@"icon_album"] forState:UIControlStateNormal];
    pictureButton.backgroundColor = [UIColor redColor];
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
    [cameraButton setImage:[UIImage imageNamed:@"icon_fanzhuan_photo"] forState:UIControlStateNormal];
    cameraButton.backgroundColor = [UIColor redColor];
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
    self.coverPageImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 150)];
    self.coverPageImage.backgroundColor = [UIColor redColor];
    self.coverPageImage.userInteractionEnabled = YES;
//    self.coverPageImage.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tagGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagGestureClick)];
    [self.coverPageImage addGestureRecognizer:tagGesture];
    [self.scrollView addSubview:self.coverPageImage];
    
    self.coverPageLabel = [[UILabel alloc]init];
    self.coverPageLabel.text = @"添加封面";
    self.coverPageLabel.font = LSFont_Size_18;
    self.coverPageLabel.textColor = [UIColor mainColor];
    [self.coverPageImage addSubview:self.coverPageLabel];
    [self.coverPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.coverPageImage);
    }];
    
    self.promptLabel = [[UILabel alloc]init];
    self.promptLabel.text = @"精致的封面为美文增加人气";
    self.promptLabel.font = LSFont_Size_13;
    self.promptLabel.textColor = [UIColor blackColor];
    [self.coverPageImage addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverPageLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self.coverPageImage);
    }];
    
    self.titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.coverPageImage.frame) + 10, kScreenWidth - 30, 50)];
    self.titleTextField.delegate = self;
    self.titleTextField.font = [UIFont boldSystemFontOfSize:17];
    self.titleTextField.placeholder = @"请输入标题";
    self.titleTextField.adjustsFontSizeToFitWidth = YES;
    [self.scrollView addSubview:self.titleTextField];
    
    self.titleLine = [[LSLineView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleTextField.frame), kScreenWidth - 30, 1)];
    self.titleLine.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8" alpha:1.0];
    [self.scrollView addSubview:self.titleLine];
    
    self.contentTextView = [[ArticleContentTextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLine.frame) + 10, kScreenWidth - 30, CGRectGetMidY(self.pictureView.frame) - CGRectGetMaxY(self.titleLine.frame) - 10)];
    self.contentTextView.scrollEnabled = NO;
    self.contentTextView.delegate = self;
    self.contentTextView.placeholder = @"正文";
    self.contentTextView.font = LSFont_Size_15;
    [self.scrollView addSubview:self.contentTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return YES;
}

#pragma mark - private
- (void)_keyboardlisten {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Event
//发布
- (void)rightItemClick {
    
}

//封面
- (void)tagGestureClick {
    [self _getCoverImage];
}

//图片
- (void)pictureButtonClick:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"Login"];
//    UIImage *modifyImage = [UIImage imageResize:image resizeTo:CGSizeZero];
    float actualWidth = image.size.width * image.scale;
    float boundsWitdh = kScreenWidth - 30;
    float compressionQuality = boundsWitdh /  actualWidth;
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
//相机
- (void)cameraButtonClick:(UIButton *)sender {
    NSArray *content = [LMTextHTMLParser HTMLFromAttributedString:self.contentTextView.attributedText];
    
//    NSArray *arr = [content componentsSeparatedByString:@"<img"];
    
    NSLog(@"%@",content);
    
//    NSLog(@"%@",content);
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
        self.pictureView.frame = CGRectMake(0, kScreenHeight - keyBoardEndH - PictureViewHeight - kBarHeight - kNavbarAndStatusBar, kScreenWidth, PictureViewHeight);
        self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - PictureViewHeight - kNavbarAndStatusBar - kBarHeight - keyBoardEndH);
    }];
}

//当键盘退出
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    //    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.pictureView.frame = CGRectMake(0, kScreenHeight - PictureViewHeight - kBarHeight - kNavbarAndStatusBar, kScreenWidth, PictureViewHeight);
        self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - PictureViewHeight - kNavbarAndStatusBar - kBarHeight);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Private
- (void)_getCoverImage {
    UIImage *image = [UIImage imageNamed:@"Login"];
    UIImage *modifyImage = [UIImage imageResize:image resizeTo:CGSizeZero];
    self.coverPageImage.height = modifyImage.size.height;
    self.coverPageImage.image = modifyImage;
    self.titleTextField.y = CGRectGetMaxY(self.coverPageImage.frame) + 10;
    self.titleLine.y = CGRectGetMaxY(self.titleTextField.frame);
    self.contentTextView.y = CGRectGetMaxY(self.titleLine.frame) + 10;
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.contentTextView.frame) + 20);
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
    typingAttributes[NSFontAttributeName] = LSFont_Size_15;
    typingAttributes[NSForegroundColorAttributeName] = [UIColor redColor];
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
    self.contentTextView.height = height;
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.contentTextView.frame) + 20);
}


@end

//
//  LoginViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/1/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LoginViewController.h"
#import "LSSingleTextField.h"
#import "LSSingleButton.h"
#import "LSSingleLabel.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) LSSingleLabel *nameLabel;
@property (nonatomic, strong) LSSingleTextField *codingTextField;
@property (nonatomic, strong) LSSingleTextField *phoneTextField;
@property (nonatomic, strong) LSSingleTextField *passwordTextField;
@property (nonatomic, strong) LSSingleButton *loginButton;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置背景图片
    UIImage *backGroundImage = [UIImage imageNamed:@"icon_login&Register_back"];
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageByApplyingImage:backGroundImage alpha:0.2].CGImage);
    [self _reminderNotification];
    [self setUpUI];
    [self viewLayout];
}


- (void)setUpUI {
    self.headImage = [[UIImageView alloc]init];
    self.headImage.image = [UIImage imageNamed:@"head"];
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = 40;
    [self.view addSubview:self.headImage];
    
    self.nameLabel = [[LSSingleLabel alloc]init];
    self.nameLabel.label_text(@"Welcome").text_color([UIColor textColor35343D]).text_bold(24);
    [self.view addSubview:self.nameLabel];
    
    self.codingTextField = [[LSSingleTextField alloc]init];
    self.codingTextField.border([UIColor boderLineColor], 1, 25).leftImage(@"icon_coding", 50).buttonMode(UITextFieldViewModeWhileEditing).placeholderStr(@"使用语言").placeholderColor([UIColor boderLineColor]);
    @WeakObj(self);
    self.codingTextField.action(^(NSString *str) {
        [selfWeak _buttonSelect];
    });
    
    [self.view addSubview:self.codingTextField];
    
    self.phoneTextField = [[LSSingleTextField alloc]init];
    self.phoneTextField.border([UIColor boderLineColor], 1, 25).buttonMode(UITextFieldViewModeWhileEditing).leftImage(@"icon_ user", 50).placeholderStr(@"请输入手机号").placeholderColor([UIColor boderLineColor]);
    self.phoneTextField.action(^(NSString *str) {
        [selfWeak _buttonSelect];
    });
    [self.view addSubview:self.phoneTextField];
    
    self.passwordTextField = [[LSSingleTextField alloc]init];
    self.passwordTextField.border([UIColor boderLineColor], 1, 25).buttonMode(UITextFieldViewModeWhileEditing).isMe(YES).leftImage(@"icon_password", 50).placeholderStr(@"请输入密码").placeholderColor([UIColor boderLineColor]);
    self.passwordTextField.action(^(NSString *str) {
        [selfWeak _buttonSelect];
    });
    [self.view addSubview:self.passwordTextField];

    self.loginButton = [[LSSingleButton alloc]init];
    self.loginButton.bcakColor([UIColor buttonNoSelectColor]).border(nil, 0, 25).button_name(NSLocalizedString(LoginButton, nil)).isSelect(NO);
    //    NSlocalizeString 第一个参数是内容,根据第一个参数去对应语言的文件中取对应的字符串，第二个参数将会转化为字符串文件里的注释，可以传nil，也可以传空字符串@""。
    [self.loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
}

- (void)viewLayout {
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.height.width.offset(80);
        make.centerX.equalTo(self.view);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    [self.codingTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(30);
        make.width.offset(kScreenWidth - 60);
        make.height.offset(50);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codingTextField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(30);
        make.width.offset(kScreenWidth - 60);
        make.height.offset(50);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(30);
        make.width.offset(kScreenWidth - 60);
        make.height.offset(50);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(30);
        make.width.offset(kScreenWidth - 60);
        make.height.offset(50);
    }];
}

#pragma mark -
- (void)_reminderNotification {
    NSDate *now = [NSDate date];
    UILocalNotification *reminderNotification = [[UILocalNotification alloc]init];
    [reminderNotification setFireDate:[now dateByAddingTimeInterval:20]];
    [reminderNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    [reminderNotification setAlertBody:@"我就是通知一下"];
    [reminderNotification setAlertTitle:@"通知"];
    [reminderNotification setAlertLaunchImage:@"Login"];
    [reminderNotification setAlertAction:@"确定"];
    reminderNotification.userInfo = @{@"QQ":@"55555",@"info":@"约了没"};
//    [reminderNotification setAlertAction:@"取消"];
    [reminderNotification setSoundName:UILocalNotificationDefaultSoundName];
    [reminderNotification setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication]scheduleLocalNotification:reminderNotification];
}

- (void)_buttonSelect {
    if (![LSSettingUtil dataAndStringIsNull:self.codingTextField.text] && ![LSSettingUtil dataAndStringIsNull:self.phoneTextField.text] && ![LSSettingUtil dataAndStringIsNull:self.passwordTextField.text]) {
         self.loginButton.bcakColor([UIColor mainColor]).isSelect(YES);
    }else {
        self.loginButton.bcakColor([UIColor buttonNoSelectColor]).isSelect(NO);
    }
}


#pragma mark - 按钮
- (void)loginClick:(UIButton *)sender {
    [(AppDelegate *)[UIApplication sharedApplication].delegate gotoMian];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

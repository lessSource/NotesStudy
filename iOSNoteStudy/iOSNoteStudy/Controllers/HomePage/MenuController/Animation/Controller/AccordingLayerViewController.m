//
//  AccordingLayerViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/17.
//  Copyright © 2018年 lj. All rights reserved.
//  显示层动画

#import "AccordingLayerViewController.h"
#import "CustomNotificationCenter.h"

@interface AccordingLayerViewController ()
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) DrawCircle *view2;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation AccordingLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"显示层动画";
    
    DrawCircle *view2 = [[DrawCircle alloc] initWithFrame:CGRectMake(30, 20, 200, 200)];

    self.view2 = view2;

    view2.centerPoint = CGPointMake(100, 100);

    view2.radius = 50;

    view2.angleValue = 20;

    view2.lineWidth = 5;

    view2.lineColor = [UIColor orangeColor];

    [self.view addSubview:view2];
    
    self.loginButton = [[UIButton alloc]init];
    self.loginButton.layer.cornerRadius = 25;
    self.loginButton.clipsToBounds = YES;
    self.loginButton.backgroundColor = [UIColor mainColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.height.offset(50);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CustomNotificationCenter defaultCenter] postNotificationName:@"CustomNotificationCenter"];
    });
    
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(15, kScreenHeight - kNavbarAndStatusBar - 50, kScreenWidth - 30, 30)];
    self.slider.maximumValue = 360;
    self.slider.value = 20;
    [self.slider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
}

- (void)sliderClick:(UISlider *)slider {
    NSLog(@"%f",slider.value);
    self.view2.angleValue = slider.value;
    [self.view2 setNeedsDisplay];
}

- (void)loginButtonClick:(UIButton *)sender {
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.index * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.loginButton.transform = endAngle;
    } completion:^(BOOL finished) {
        self.index += 2;
        [self loginButtonClick:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




@implementation DrawCircle

 

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    self.backgroundColor = [UIColor whiteColor];

    self.lineWidth = 10;

    self.bgLineColor = [UIColor lightGrayColor];

    self.lineColor = [UIColor orangeColor];

    return self;

}

 

 

- (void)drawRect:(CGRect)rect {

    CGContextRef bgContextRef = UIGraphicsGetCurrentContext();

    CGContextAddArc(bgContextRef, _centerPoint.x, _centerPoint.y, _radius, 0, 10, 0);

    CGContextSetLineWidth(bgContextRef, _lineWidth);

    [_bgLineColor setStroke];

    CGContextStrokePath(bgContextRef);

    

    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    CGContextAddArc(contextRef, _centerPoint.x, _centerPoint.y, _radius, M_PI/2, M_PI/2+_angleValue/180*M_PI, 0);

    CGContextSetLineWidth(contextRef, _lineWidth);

    [_lineColor setStroke];

    CGContextStrokePath(contextRef);

}

@end

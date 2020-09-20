//
//  ArticleSourceView.m
//  Behing
//
//  Created by Lj on 2018/7/16.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ArticleSourceView.h"
#import "LineView.h"

@interface ArticleSourceView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *originalButton;
@property (nonatomic, strong) UIButton *reprintedButton;
@property (nonatomic, strong) UIButton *determineButton;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ArticleSourceView

- (void)willShowView {
    [super willShowView];
    self.nameLabel.text = @"是原创？还是转载？";
    self.reprintedButton.hidden = NO;
    self.originalButton.hidden = NO;
    self.determineButton.hidden = YES;
    self.inputView.hidden = YES;
    self.textField.text = @"";
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"icon_posted_Delete"] forState:UIControlStateNormal];
    [self addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.height.width.offset(45);
        make.right.equalTo(self.mas_right).offset(- 5);
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"是原创？还是转载？";
    self.nameLabel.textColor = Text_Color_333333;
    self.nameLabel.font = BHFont_Size_17;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(30);
    }];
    
    self.originalButton = [[UIButton alloc]init];
    [self.originalButton setTitle:@"原创" forState:UIControlStateNormal];
    [self.originalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.originalButton.backgroundColor = Main_Color;
    [self.originalButton addTarget:self action:@selector(originalButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.originalButton];
    [self.originalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(30);
        make.height.offset(45);
        make.width.offset(155);
    }];
    
    self.reprintedButton = [[UIButton alloc]init];
    [self.reprintedButton setTitle:@"转载" forState:UIControlStateNormal];
    [self.reprintedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reprintedButton.backgroundColor = Main_Color;
    [self.reprintedButton addTarget:self action:@selector(reprintedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.reprintedButton];
    [self.reprintedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.originalButton.mas_bottom).offset(30);
        make.height.offset(45);
        make.width.offset(155);
    }];
    
    self.determineButton = [[UIButton alloc]init];
    [self.determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.determineButton.hidden = YES;
    self.determineButton.backgroundColor = Main_Color;
    [self.determineButton addTarget:self action:@selector(determineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.determineButton];
    [self.determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.offset(45);
        make.width.offset(155);
        make.bottom.equalTo(self.mas_bottom).offset(- 30);
    }];
    
    self.inputView = [[UIView alloc]init];
    self.inputView.backgroundColor = [UIColor clearColor];
    self.inputView.hidden = YES;
    [self addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self.mas_right).offset(- 30);
        make.bottom.equalTo(self.determineButton.mas_top).offset(- 30);
        make.height.offset(45);
    }];
    
    LineView *lineView = [[LineView alloc]init];
    lineView.backgroundColor = Dividing_Line_Color;
    [self.inputView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(BHLine_Height * 2);
        make.left.equalTo(self.inputView);
        make.right.equalTo(self.inputView.mas_right);
        make.bottom.equalTo(self.inputView.mas_bottom);
    }];
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"输入"];
    [self.inputView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(20);
        make.bottom.equalTo(self.inputView.mas_bottom).offset(- 10);
        make.left.equalTo(self.inputView);
    }];
    
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = @"来自";
    self.textField.font = BHFont_Size_15;
    [self.inputView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(5);
        make.right.equalTo(self.inputView.mas_right).offset(- 15);
        make.bottom.equalTo(self.inputView.mas_bottom);
        make.top.equalTo(self.inputView.mas_top).offset(5);
    }];
}


#pragma mark - Event
//取消
- (void)cancelButtonClick:(UIButton *)sender {
    [[PopUpViewObjeect sharrPopUpView] cancalContentView:self direction:PopUpViewDirectionTypeCenter];
}

//原创
- (void)originalButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPopUpView:data:)]) {
        [[PopUpViewObjeect sharrPopUpView] cancalContentView:self direction:PopUpViewDirectionTypeCenter];
        [self.delegate selectPopUpView:self data:nil];
    }
}

//转载
- (void)reprintedButtonClick:(UIButton *)sender {
    self.nameLabel.text = @"您的美文来自哪？";
    self.reprintedButton.hidden = YES;
    self.originalButton.hidden = YES;
    self.determineButton.hidden = NO;
    self.inputView.hidden = NO;
}

//确定
- (void)determineButtonClick:(UIButton *)sender {
    if ([BHSettingUtil dataAndStringIsNull:self.textField.text]) {
        [[BHAlertUtil alertManager] showPromptInfo:@"请输入转载来源"];
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectPopUpView:data:)]) {
            [[PopUpViewObjeect sharrPopUpView] cancalContentView:self direction:PopUpViewDirectionTypeCenter];
            [self.delegate selectPopUpView:self data:self.textField.text];
        }
    }
}


@end

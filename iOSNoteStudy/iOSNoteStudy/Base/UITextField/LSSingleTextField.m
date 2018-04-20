//
//  LSSingleTextField.m
//  NotesStudy
//
//  Created by Lj on 2018/1/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSSingleTextField.h"

@interface LSSingleTextField ()
@property (nonatomic, copy) ActionText actionBlock;
@end

@implementation LSSingleTextField

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (LSSingleTextField *(^)(NSString *placeholder))placeholderStr {
    return ^id(NSString *placeholder) {
        self.placeholder = placeholder;
        return self;
    };
}

- (LSSingleTextField *(^)(UIColor *placeholderColor))placeholderColor {
    return ^id(UIColor *placeholderColor) {
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        return self;
    };
}

- (LSSingleTextField *(^)(UIColor *backgroundColor))backColor {
    return ^id(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (LSSingleTextField *(^)(NSString *imageStr, CGFloat height))leftImage {
    return ^id(NSString *imageStr, CGFloat height) {
        [self _setTextFieldattributeImageStr:imageStr height:height];
        return self;
    };
}

- (LSSingleTextField *(^)(UIFont *font))text_font {
    return ^id(UIFont *font) {
        self.font = font;
        return self;
    };
}

- (LSSingleTextField *(^)(CGFloat margin))leftMargin {
    return ^id(CGFloat margin) {
        [self _setTextFieldLeftMargin:margin];
        return self;
    };
}

- (LSSingleTextField *(^)(BOOL isMe))isMe {
    return ^id(BOOL isMe) {
        self.secureTextEntry = isMe;
        return self;
    };
}

- (LSSingleTextField *(^)(UITextFieldViewMode textFieldViewModel))buttonMode {
    return ^id(UITextFieldViewMode textFieldViewModel) {
        self.clearButtonMode = textFieldViewModel;
        return self;
    };
}

- (LSSingleTextField *(^)(UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius))border {
    return ^id(UIColor *borderColor, CGFloat borderWidth, CGFloat cornerRadius) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

- (LSSingleTextField *(^)(ActionText action))action {
    return ^id(ActionText action) {
        [self addTarget:self action:@selector(textChangeClick:) forControlEvents:UIControlEventEditingChanged];
        self.actionBlock = action;
        return self;
    };
}

- (void)_setTextFieldLeftMargin:(CGFloat)leftMargin {
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftMargin, 0)];
    self.contentMode = UIViewContentModeCenter;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}

//设置TestField属性
-(void)_setTextFieldattributeImageStr:(NSString *)str height:(CGFloat)height {
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, height)];
    UIImageView *leftImage = [[UIImageView alloc]init];
    leftImage.image = [UIImage imageNamed:str];
    [leftView addSubview:leftImage];
    
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView);
        make.height.width.offset(20);
        make.left.equalTo(leftView).offset(12);
    }];
    self.contentMode = UIViewContentModeCenter;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}

- (void)textChangeClick:(UITextField *)textField {
    if (self.actionBlock) {
        self.actionBlock(textField.text);
    }
}

@end

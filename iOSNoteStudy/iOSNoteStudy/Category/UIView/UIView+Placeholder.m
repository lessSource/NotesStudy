//
//  UIView+Placeholder.m
//  Error
//
//  Created by Lj on 2017/9/26.
//  Copyright © 2017年 lj. All rights reserved.
//

#import "UIView+Placeholder.h"
#import <objc/runtime.h>
#import "BaseTableView.h"

#define Prompt_Image_Width 150
#define Prompt_Image_height 120

#define Prompt_Image_Y 150
#define Prompt_View_Tag 237823
static const char btnKey;

@interface UIView ()

@end

@implementation UIView (Placeholder)

#pragma mark - 显示
- (UIView *(^)(BOOL show))placeholderShow {
    return ^id(BOOL isShow) {
        if (isShow) [self showPromptView];
        else [self removePromptView];
        return self;
    };
}

#pragma mark - show
- (void)showPromptView {
    UIView *prompt_view = [self promptView];
    if ([self isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)self setScrollEnabled:NO];
    }
    if (self.subviews.count > 0) {
        UIView *t_v = self;
        for (UIView *v in self.subviews) {
            if ([v isKindOfClass:[BaseTableView class]]) {
                t_v = v;
            }
        }
        [t_v insertSubview:prompt_view aboveSubview:t_v.subviews[0]];
        prompt_view.backgroundColor = t_v.backgroundColor;
    }else {
        [self addSubview:prompt_view];
    }
}

#pragma mark - remove
- (void)removePromptView {
    UIView *prompt_view = [self getPromptView];
    if (prompt_view) {
        if ([self isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)self setScrollEnabled:YES];
        }
        [prompt_view removeFromSuperview];
    }
}

- (void)actionWithBlock:(dispatch_block_t)block {
    if (block) {
        // 动态为UIButton关联block
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma makr - 提示View
- (UIView *)getPromptView {
    UIView *prompt_view = objc_getAssociatedObject(self, @selector(promptView));
    return prompt_view;
}

- (UIView *)setPromptView {
    UIView *prompt_view = objc_getAssociatedObject(self, @selector(promptView));
    return prompt_view;
}

- (void)setPromptVieww:(UIView *)view {
    objc_setAssociatedObject(self, @selector(promptView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)promptView {
    UIView *prompt_view = [self getPromptView];
    if (prompt_view) {
        return prompt_view;
    }
    prompt_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [self setPromptVieww:prompt_view];
    
    UIImageView *prompt_Image = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(prompt_view.bounds) - Prompt_Image_Width)/2, Prompt_Image_Y, Prompt_Image_Width, Prompt_Image_height)];
    prompt_Image.contentMode = UIViewContentModeCenter;
    prompt_Image.image = [UIImage imageNamed:@"icon_noData"];
    prompt_Image.tag = Prompt_View_Tag + 1;
    [prompt_view addSubview:prompt_Image];
    
    UILabel *prompt_title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(prompt_Image.frame) + 5, CGRectGetWidth(prompt_view.bounds), 30)];
    prompt_title.text = @"暂无数据";
    prompt_title.textColor = [UIColor colorWithHexString:@"#A0A0A0" alpha:1.0];
    prompt_title.textAlignment = NSTextAlignmentCenter;
    prompt_title.tag = Prompt_View_Tag + 2;
    [prompt_view addSubview:prompt_title];
    
    UIButton *prompt_button = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(prompt_title.frame),CGRectGetWidth(prompt_view.bounds) - 100 , 30)];
    prompt_button.hidden = YES;
    prompt_button.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [prompt_button setTitle:@"重新加载" forState:UIControlStateNormal];
    [prompt_button setTitleColor:[UIColor colorWithHexString:@"#A0A0A0" alpha:1.0] forState:UIControlStateNormal];
    prompt_button.tag = Prompt_View_Tag + 3;
    [prompt_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [prompt_view addSubview:prompt_button];

    return prompt_view;
}

- (void)buttonClick {
    dispatch_block_t block = objc_getAssociatedObject(self, &btnKey);
    if (block) {
        block();
        [self removePromptView];
    }
}

#pragma mark -
- (UIView * (^)(NSString *title))prompt_title {
    return ^id(NSString *title) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UILabel *lable = [prompt_view viewWithTag:Prompt_View_Tag + 2];
            lable.text = title;
            UIImageView *image = [prompt_view viewWithTag:Prompt_View_Tag + 1];
            if ([title isEqualToString:@"暂无内容"]) {
                image.image = [UIImage imageNamed:@"icon_noNetwork"];
            }else {
                image.image = [UIImage imageNamed:@"icon_noData"];
            }
        }
        return self;
    };
}

- (UIView * (^)(UIFont *font))prompt_Font {
    return ^id(UIFont *font) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UILabel *lable = [prompt_view viewWithTag:Prompt_View_Tag + 2];
            lable.font = font;
        }
        return self;
    };
}

- (UIView *(^)(CGRect rect))prompt_frame {
    return ^id(CGRect rect) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UIImageView *image = [prompt_view viewWithTag:Prompt_View_Tag + 1];
            image.frame = rect;
            UILabel *lable = [prompt_view viewWithTag:Prompt_View_Tag + 2];
            lable.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 5, CGRectGetWidth(prompt_view.bounds), 30);
        }
        return self;
    };
}

- (UIView *(^)(CGFloat top))prompt_image_top {
    return ^id(CGFloat top) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UIImageView *image = [prompt_view viewWithTag:Prompt_View_Tag + 1];
            CGRect rect = image.frame;
            rect.origin.y = top;
            image.frame = rect;
            UILabel *lable = [prompt_view viewWithTag:Prompt_View_Tag + 2];
            lable.frame = CGRectMake(0, CGRectGetMaxY(image.frame) + 5, CGRectGetWidth(prompt_view.bounds), 30);
        }
        return self;
    };
}

- (UIView * (^)(NSString *imageStr))prompt_image {
    return ^id(NSString *imageStr) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UIImageView *image = [prompt_view viewWithTag:Prompt_View_Tag + 1];
            image.image = [UIImage imageNamed:imageStr];
        }
        return self;
    };
}

- (UIView *(^)(NSString *buttonName))button_name {
    return ^id(NSString *name) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UIButton *button = [prompt_view viewWithTag:Prompt_View_Tag + 3];
            [button setTitle:name forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIView * (^)(UIFont *font))button_Font {
    return ^id(UIFont *font) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UIButton *button = [prompt_view viewWithTag:Prompt_View_Tag + 3];
            button.titleLabel.font = font;
        }
        return self;
    };
}

- (UIView *(^)(BOOL hidden))isButtonHidden {
    return ^id(BOOL hidden) {
        UIView *prompt_view = [self getPromptView];
        if (prompt_view) {
            UIButton *button = [prompt_view viewWithTag:Prompt_View_Tag + 3];
            button.hidden = hidden;
        }
        return self;
    };
}

- (void)getButtonUIView:(void(^)(UIButton *button))block {
    UIView *prompt_view = [self getPromptView];
    if (prompt_view) {
        UIButton *button = [prompt_view viewWithTag:Prompt_View_Tag + 3];
        block(button);
    }
}


@end

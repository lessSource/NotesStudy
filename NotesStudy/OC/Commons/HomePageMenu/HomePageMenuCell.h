//
//  HomePageMenuCell.h
//  NoteDome
//
//  Created by Lj on 2018/1/18.
//  Copyright © 2018年 Lj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageMenuCell : UICollectionViewCell

/** name */
@property (nonatomic, strong) UILabel *nameLabel;
/** image */
@property (nonatomic, strong) UIImageView *iconImage;
/** number Label*/
@property (nonatomic, strong) UILabel *numberLabel;
/** number */
@property (nonatomic, strong) NSString *numberStr;
/** icon image height width */
@property (nonatomic, assign) CGFloat iconImageSize;
/** icon image margin top */
@property (nonatomic, assign) CGFloat iconMarginTop;
/** name margin top */
@property (nonatomic, assign) CGFloat nameMarginTop;
/** name font */
@property (nonatomic, strong) UIFont *nameFont;
/** name color */
@property (nonatomic, strong) UIColor *nameColor;

@end





//
//  QrCodeScanningViewController.h
//  Community
//
//  Created by Lj on 2017/8/11.
//  Copyright © 2017年 lj. All rights reserved.
//

@protocol QrCodeScanningViewDelegate <NSObject>

- (void)QrCodeScanningViewStr:(NSString *)stringValue;

@end

#import "BaseViewController.h"


@interface QrCodeScanningViewController : BaseViewController

@property (nonatomic, assign) id <QrCodeScanningViewDelegate> QRDelegate;

@end

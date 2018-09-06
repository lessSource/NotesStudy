//
//  LSHTTPRequest.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/10.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 请求成功 */
typedef void(^LSRequestSuccess)(id results, BOOL success);

/** 请求失败 */
typedef void(^LSRequestFailure)(NSError *error);

@interface LSHTTPRequest : NSObject

/** GitHub 搜索 */
+ (void)requestGetGitHubSearch:(LSRequestSuccess)result params:(NSDictionary *)params;


@end









//
//  CircleFriendsContentModel.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentsReplyModel.h"

@class GiveLikeUserModel;

@interface CircleFriendsContentModel : NSObject
/** 内容ID */
@property (nonatomic, strong) NSString *contentId;
/** 内容 */
@property (nonatomic, strong) NSString *content;
/** 图片 */
@property (nonatomic, strong) NSArray <NSString *> *imageArray;
/** 用户头像 */
@property (nonatomic, strong) NSString *headUrl;
/** 用户昵称 */
@property (nonatomic, strong) NSString *userName;
/** 发布时间 */
@property (nonatomic, strong) NSString *time;
/** 评论内容 */
@property (nonatomic, strong) NSArray <CommentsReplyModel *> *commentsModel;
/** 点赞人 */
@property (nonatomic, strong) NSArray <GiveLikeUserModel *> *giveLikeArray;

@end

@interface GiveLikeUserModel : NSObject
/** 用户ID */
@property (nonatomic, strong) NSString *userId;
/** 用户昵称 */
@property (nonatomic, strong) NSString *userModel;
/** 用户头像 */
@property (nonatomic, strong) NSString *headUrl;

@end




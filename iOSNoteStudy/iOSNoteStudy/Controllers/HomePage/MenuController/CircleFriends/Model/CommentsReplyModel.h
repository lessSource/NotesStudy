//
//  CommentsReplyModel.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsReplyModel : NSObject
/** 评论ID */
@property (nonatomic, strong) NSString *contentId;
/** 评论内容 */
@property (nonatomic, strong) NSString *conetnt;

/** 回复人 */
@property (nonatomic, strong) NSString *replyName;
/** 回复人ID */
@property (nonatomic, strong) NSString *replyId;
/** 回复人头像 */
@property (nonatomic, strong) NSString *replyUrl;

/** 评论人 */
@property (nonatomic, strong) NSString *commentsName;
/** 评论人ID */
@property (nonatomic, strong) NSString *commentsId;
/** 评论人头像 */
@property (nonatomic, strong) NSString *commentsUrl;

@end

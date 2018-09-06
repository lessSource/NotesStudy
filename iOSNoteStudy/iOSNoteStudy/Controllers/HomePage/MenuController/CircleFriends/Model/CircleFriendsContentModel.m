//
//  CircleFriendsContentModel.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "CircleFriendsContentModel.h"

@implementation CircleFriendsContentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"commentsModel" : [CommentsReplyModel class] , @"giveLikeArray" : [GiveLikeUserModel class]};
}

@end


@implementation GiveLikeUserModel

@end

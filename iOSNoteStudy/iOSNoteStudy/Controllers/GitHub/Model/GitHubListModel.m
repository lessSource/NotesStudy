//
//  GitHubListModel.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/9.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "GitHubListModel.h"

@implementation GitHubListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [GitHubListItemModel class]};
}

@end

@implementation GitHubListItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"listId" : @"id", @"projectDescription" : @"description"};
}


@end

@implementation GitHubListOwnerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @"id"};
}

@end

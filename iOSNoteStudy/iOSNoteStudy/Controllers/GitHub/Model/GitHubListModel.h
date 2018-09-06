//
//  GitHubListModel.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/9.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GitHubListItemModel, GitHubListOwnerModel;

@interface GitHubListModel : NSObject
/** 总数 */
@property (nonatomic, assign) NSInteger total_count;
/** 结果是否完整 */
@property (nonatomic, assign) BOOL incomplete_results;
/** ItmeModel */
@property (nonatomic, strong) NSArray <GitHubListItemModel *>*items;

@end


@interface GitHubListItemModel: NSObject
/** 列表id */
@property (nonatomic, strong) NSString *listId;
/** 项目名称 */
@property (nonatomic, strong) NSString *name;
/** 项目全名 */
@property (nonatomic, strong) NSString *full_name;
/** 项目描述 */
@property (nonatomic, strong) NSString *projectDescription;
/** 项目地址 */
@property (nonatomic, strong) NSString *html_url;
/** 创建时间 */
@property (nonatomic, strong) NSString *created_at;
/** 更新时间 */
@property (nonatomic, strong) NSString *updated_at;
/** 最近push时间 */
@property (nonatomic, strong) NSString *pushed_at;
/** svn地址 */
@property (nonatomic, strong) NSString *svn_url;
/** star */
@property (nonatomic, assign) NSInteger stargazers_count;

/** OwnerModel */
@property (nonatomic, strong) GitHubListOwnerModel *owner;

@end

@interface GitHubListOwnerModel: NSObject

/** 用户 */
@property (nonatomic, strong) NSString *login;
/** 用户ID */
@property (nonatomic, strong) NSString *userId;
/** 用户头像 */
@property (nonatomic, strong) NSString *avatar_url;
/** 用户信息 */
@property (nonatomic, strong) NSString *url;

/**  */
@property (nonatomic, strong) NSString *type;
/**  */
@property (nonatomic, assign) BOOL site_admin;

@end


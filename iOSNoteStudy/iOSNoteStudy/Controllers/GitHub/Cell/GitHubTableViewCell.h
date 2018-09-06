//
//  GitHubTableViewCell.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/26.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GitHubListModel.h"

@interface GitHubTableViewCell : BaseTableViewCell

@property (nonatomic, strong) GitHubListItemModel *item;

@end

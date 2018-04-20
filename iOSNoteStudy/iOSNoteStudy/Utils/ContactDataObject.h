//
//  ContactDataObject.h
//  NotesStudy
//
//  Created by Lj on 2018/3/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactDataObject : NSObject

+ (ContactDataObject *)shareInstance;

//链接数据库
- (void)createDataBase;

//插入数据
- (void)insertData:(id)data;

//删除数据
- (void)deleteData:(NSString *)userId;

@end

//
//  ContactDataObject.m
//  NotesStudy
//
//  Created by Lj on 2018/3/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#define DB_CONTACT_TABLE @"contactData.sqlite"
#define DB_CONTACT_USER_LIST @"contactList"   //用户表
#define DB_CONTACT_SEARCH_LIST @"searchList"  //搜索表

#define DB_CONTACH_POETRY_TABLE @"poetry.sqlite"
#define DB_CONTACH_POETRY_LIST @"poetryData"     //诗词表

#import "ContactDataObject.h"
#import <FMDB/FMDB.h>

static ContactDataObject *contactDataObject;

@interface ContactDataObject ()
@property (nonatomic, strong) FMDatabase *dataDB;

@end

@implementation ContactDataObject

+ (ContactDataObject *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contactDataObject = [[ContactDataObject alloc]init];
    });
    return contactDataObject;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//        PoetryPath
        NSString *dataPath = [docPath stringByAppendingPathComponent:DB_CONTACH_POETRY_TABLE];
        NSLog(@"%@",dataPath);
        self.dataDB = [[FMDatabase alloc]initWithPath:dataPath];
    }
    return self;
}

- (void)createDataBase {
    //调用open的时候 如果数据库不存在会先创建在打开，如果存在就直接打开
    if ([self.dataDB open]) {
        //数据库一半只打开一次
        if (![self _isTableOK:DB_CONTACH_POETRY_LIST]) {
            [self _createTable];
        }
    }else {
        NSLog(@"create table error:%@",self.dataDB.lastErrorMessage);
    }
}

- (void)insertData:(id)data {
    [self queryData:data];
}

//关闭数据库
- (void)closeData {
    [self.dataDB close];
}

//导入数据
- (void)insertPoetryData:(id)data {
    if ([LSSettingUtil dataAndStringIsNull:data]) {
        return;
    }
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
        NSString *timeStr = [NSString stringWithFormat:@"%.f",interval];
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (poetry_title, poetry_author, poetry_dynasty, poetry_strains, poetry_paragraphs, create_time)values(?, ?, ?, ?, ?, ?)",DB_CONTACH_POETRY_LIST];
        BOOL isSuccess = [self.dataDB executeUpdate:sql, dic[@"title"], dic[@"author"], dic[@"dynasty"], dic[@"strains"], dic[@"paragraphs"], timeStr];
        if (!isSuccess) {
            NSLog(@"insert into error :%@",self.dataDB.lastErrorMessage);
        }else {
            NSLog(@"添加数据成功");
        }
    }
}


- (id)queryData:(id)data {
    if ([LSSettingUtil dataAndStringIsNull:data]) {
        return nil;
    }
    if ([data isKindOfClass:[NSString class]]) {
        return [self _queryData:data];
    }else if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@'",DB_CONTACT_USER_LIST,dic[@"userId"]];
        FMResultSet *rs = [self.dataDB executeQuery:sql];
        while ([rs next]) {
            [self _withTheData:data];
            return data;
        }
        [self _insertData:data];
        return data;
    }
    return nil;
}

//删除数据
- (void)deleteData:(NSString *)userId {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE userId = %@",DB_CONTACT_USER_LIST,userId];
    BOOL isSuccess = [self.dataDB executeUpdate:sql];
    if (!isSuccess) {
        NSLog(@"delete error: %@",self.dataDB.lastErrorMessage);
    }
}

#pragma mark -
- (BOOL)_isTableOK:(NSString *)tableName {
    FMResultSet *rs = [self.dataDB executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type = 'table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (count == 0) {
            return NO;
        }else {
            return YES;
        }
    }
    return NO;
}

//创建表
- (void)_createTable {
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@ (primaryId integer primary key autoincrement not null,userId text, userName text, password text, time text)",DB_CONTACT_USER_LIST];
    
    BOOL isSuccess = [self.dataDB executeUpdate:sql];
    if (isSuccess) {
        NSLog(@"创建表成功");
    }else {
        NSLog(@"create table error: %@",self.dataDB.lastErrorMessage);
    }
}

//查询数据
- (id)_queryData:(NSString *)dataStr {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@'",DB_CONTACT_USER_LIST,dataStr];
    FMResultSet *rs = [self.dataDB executeQuery:sql];
    while ([rs next]) {
        NSString *userName = [rs stringForColumn:@"userName"];
        NSString *password = [rs stringForColumn:@"password"];
        NSDictionary *dic = @{@"userId": dataStr, @"userName": userName, @"password" : password};
        return dic;
    }
    NSDictionary *dic = @{@"userId": dataStr, @"userName": @"", @"password" : @""};
    return dic;
}

//插入数据
- (void)_insertData:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
        NSString *timeStr = [NSString stringWithFormat:@"%.f",interval];
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (userId, userName, password, time)values(?, ?, ?, ?)",DB_CONTACT_USER_LIST];
        BOOL isSuccess = [self.dataDB executeUpdate:sql, dic[@"userId"], dic[@"userName"], dic[@"password"], timeStr];
        if (!isSuccess) {
            NSLog(@"insert into error :%@",self.dataDB.lastErrorMessage);
        }else {
            NSLog(@"添加数据成功");
        }
    }
}

//更新数据
- (void)_withTheData:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
        NSString *timeStr = [NSString stringWithFormat:@"%.f",interval];
        NSString * update = [NSString stringWithFormat:@"UPDATE %@ SET userName = '%@',password = '%@' , Time = '%@' where userId = '%@'",DB_CONTACT_USER_LIST,dic[@"userName"],dic[@"password"],timeStr,dic[@"userId"]];
        BOOL isSuccess = [self.dataDB executeUpdate:update];
        if (!isSuccess) {
            NSLog(@"updata Failure");
        }
    }
}

@end



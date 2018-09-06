//
//  LSHTTPRequest.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/10.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LSHTTPRequest.h"
#import <PPNetworkHelper/PPNetworkHelper.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, kRequestStatusCode) {
    RequestFailedStatusCode  =  - 1,
    LoginFailureStatusCode   =  - 5,
};

@implementation LSHTTPRequest

#pragma mark - 请求的公共方法
//POST
+ (NSURLSessionTask *)requestPOSTWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(LSRequestSuccess)success failure:(LSRequestFailure)failure {
    //设置请求头
//    [PPNetworkHelper setValue:@"" forHTTPHeaderField:@""];
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL];
    NSLog(@"%@----%@",urlStr,parameter);
    return [PPNetworkHelper POST:urlStr parameters:parameter success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//GET
+ (NSURLSessionTask *)requestGETWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(LSRequestSuccess)success failure:(LSRequestFailure)failure {
    //设置请求头
    //    [PPNetworkHelper setValue:@"" forHTTPHeaderField:@""];
    NSString *urlStr = [NSString stringWithFormat:@"%@",URL];
    NSLog(@"%@----%@",urlStr,parameter);
    return [PPNetworkHelper GET:urlStr parameters:parameter success:^(id responseObject) {
        [self _requestSuccess:success responseObject:responseObject];
    } failure:^(NSError *error) {
        [self _requestFailure:failure];
    }];
}

#pragma mark - 请求数据失败
+ (void)_requestFailure:(LSRequestFailure)failure {
    [[LSAlertUtil alertManager]hiddenLoading];
}

#pragma mark - 请求数据成功
+ (void)_requestSuccess:(LSRequestSuccess)success responseObject:(id)responseObject {
    NSDictionary *result = (NSDictionary *)responseObject;
    success(result, true);
}

#pragma mark -
/** GitHub 搜索 */
+ (void)requestGetGitHubSearch:(LSRequestSuccess)result params:(NSDictionary *)params {
    [self requestGETWithURL:@"https://api.github.com/search/repositories" parameters:params success:result failure:nil];
}


@end


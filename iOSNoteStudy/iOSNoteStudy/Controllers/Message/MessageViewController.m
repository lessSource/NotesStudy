//
//  MessageViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/9.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "MessageViewController.h"
#import "BaseTableView.h"
#import <Photos/Photos.h>
#import "TestNurseViewController.h"

@interface MessageViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self pollingRunLoop];
    
    NSArray *array = [self getAllPhotosUsingPhotoKit];
    
    for (int i = 0; i < array.count; i ++) {
        [self accessToImageAccordingToTheAsset:array[i] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 100) resizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *image, NSDictionary *info) {
            NSLog(@"");
        }];
    }
    NSLog(@"%@",array);
    
}

//轮询 RunLoop
- (void)pollingRunLoop {
    //创建一个线程
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(createRunloopByNormal) object:nil];
    [self.thread start];
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];

}

- (void)createRunloopByNormal {
    @autoreleasepool {
        //添加port源，保证runlop正常轮询，不会创建后直接退出
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        
        //开启runloop
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)test {
    NSLog(@"dddd");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifire = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"测试";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TestNurseViewController *testNurseVC = [[TestNurseViewController alloc]init];
    [self pushViewController:testNurseVC animated:true];
}


// 获取所有照片
- (NSMutableArray *)getAllPhotosUsingPhotoKit {
    NSMutableArray *array = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (int i = 0; i < smartAlbums.count; i ++) {
        // 是否按创建时间排序
        PHFetchOptions *option = [[PHFetchOptions alloc]init];
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHCollection *collection = smartAlbums[i];
        // 遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            if (![collection.localizedTitle isEqualToString:@"相机胶卷"]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                NSArray *assets;
                if (fetchResult.count > 0) {
                    // 某个相册里面的所有PHAsset对象
                    assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES];
                    [array addObjectsFromArray:assets];
                }
            }
        }
    }
    return array;
}


// 获取相册里面所有图片的PHAsset对象
- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    // 存放所有图片对象
    NSMutableArray *assets = [NSMutableArray array];
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    // 获取所有图片对象
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    //  遍历
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:asset];
    }];
    return assets;
}

// 根据PHAsset获取图片信息
- (void)accessToImageAccordingToTheAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void(^)(UIImage *image, NSDictionary *info))completion {
    static PHImageRequestID requestID = - 2;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, 500);
    if (requestID >= 1 && size.width / width == scale) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    option.resizeMode = resizeMode;
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result, info);
        });
    }];
}


@end

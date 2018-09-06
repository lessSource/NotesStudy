//
//  LPhotoBrowser.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "LPhotoBrowser.h"
#import <Photos/Photos.h>
#import "PermissionsObject.h"
#import "LPhotoBrowserCell.h"

static NSString *const photoBrowserCell = @"PhotoBrowserCell";

@interface LPhotoBrowser () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BrowserImageViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation LPhotoBrowser

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI {    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[LPhotoBrowserCell class] forCellWithReuseIdentifier:photoBrowserCell];
    [self.view addSubview:self.collectionView];
    
    if (self.currentIndex > 0 && self.currentIndex < self.dataArray.count) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoBrowserCell forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LPhotoBrowserCell alloc]init];
    }
    cell.browseImageView.imageDelegate = self;
    cell.browseImageView.showImage = self.dataArray[indexPath.item];
    cell.browseImageView.zoomScale = 1.0;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    LPhotoBrowserCell *browserCell = (LPhotoBrowserCell *)cell;
    browserCell.browseImageView.zoomScale = 1.0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / kScreenWidth;
}

#pragma mark - BrowserImageViewDelegate
- (void)didSelectImageView:(LBrowserImageView *)imageView deleteImage:(UIImage *)currentImage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)longPressImageView:(LBrowserImageView *)imageView image:(UIImage *)currentImage {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _permissionsImage:currentImage];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deletePhotoBrowser:deleteImage:deleteIndex:)]) {
            [self.delegate deletePhotoBrowser:self deleteImage:currentImage deleteIndex:self.currentIndex];
        }
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:saveAction];
    if (self.isDelete) {
        [alertVC addAction:deleteAction];
    }
    [alertVC addAction:cancleAction];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

- (NSArray <id <UIPreviewActionItem>> *)previewActionItems NS_AVAILABLE_IOS(9_0) {
    NSMutableArray *itemArray = [NSMutableArray array];
    UIPreviewAction *saveAction = [UIPreviewAction actionWithTitle:@"保存" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        LPhotoBrowserCell *cell = (LPhotoBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
        [self _permissionsImage:cell.browseImageView.obtainImage];
    }];
    
    UIPreviewAction *deleteAction = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deletePhotoBrowser:deleteImage:deleteIndex:)]) {
            LPhotoBrowserCell *cell = (LPhotoBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
            [self.delegate deletePhotoBrowser:self deleteImage:cell.browseImageView.obtainImage deleteIndex:self.currentIndex];
        }
    }];
    
    UIPreviewAction *cancelAction = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    }];
    
    if (self.isDelete) {
        [itemArray addObjectsFromArray:@[saveAction, deleteAction, cancelAction]];
    }else {
        [itemArray addObjectsFromArray:@[saveAction, cancelAction]];
    }
    return itemArray;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    self.collectionView.contentOffset = CGPointMake(self.view.bounds.size.width * self.currentIndex, 0);
    [self.collectionView reloadData];
}

#pragma mark - Set
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (currentIndex > 0 && self.currentIndex < self.dataArray.count) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    }
}

#pragma mark - private
- (void)_permissionsImage:(UIImage *)image {
    [[PermissionsObject shareInstance] photoAlbumPermissions:^(BOOL success, NSString *message) {
        if (success) {
            [self _loadImageFinished:image];
        }else {
        }
    }];
}

- (void)_loadImageFinished:(UIImage *)image {
    
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        [imageIds addObject:request.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
            //获取自定义相册
            PHAssetCollection *collection = [self _getAssetCollectionWithAppNameAndCreateIfNo];
            if (collection == nil) { return; }
            //保存图片
            NSError *error = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                //需要操作的相册
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                //添加到自定义相册  追加  不能成为封面
                //[request addAssets:result];
                //插入到自定义相册  插入  可以成为封面
                [request insertAssets:result atIndexes:[NSIndexSet indexSetWithIndex:0]];
            } error:&error];
        }
    }];
}

- (PHAssetCollection *)_getAssetCollectionWithAppNameAndCreateIfNo {
    NSString *title = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    //获取相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    //创建
    NSError *error = nil;
    __block NSString *createID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        createID = request.placeholderForCreatedAssetCollection.localIdentifier;
    } error: &error];
    if (error) { return nil; }
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createID] options:nil].firstObject;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

##  SDWebImage

#### SDWebImage不同版本的区别

3.x

- 将UImageView类图像和缓存管理添加到Cocoa Touch框架的类别
- 异步图片下载器
- 异步内存+磁盘映像缓存，并且自动处理过期的缓存图片
- 后台图像解压缩
- 保证相同的URL不会被多次下载
- 保证伪造的URL不会一次又一次地重试
- 保证主线程永远不会被阻塞

新增功能：

- 动画GIF支持
- WebP格式支持
- 使用GCD和ARC
- Arm64支持

4.x

- 类别UIImageView, UIButton, MKAnnotationView添加Web图像和高速缓存管理
- 异步图片下载器
- 异步内存+磁盘印象缓存，并且自动处理过期的缓存图片
- 后台图像解压缩
- 保证相同的URL不会被多次下载
- 保证伪造的URL不会一次又一次的重试
- 保证主线程永远不会被阻塞
- 使用GCD和ARC

新增文件

- 缓存配置类 SDImageCacheConfig
- 一堆Decoder类 对之前SDWebImageDecoder补充优化
- 图像变换类 SDWebImageTransition
- category 新增功能调用接口

SDWebImgaeDownloader 下载图片，优化加载 SDwebImageDewnloaderOperation 处理下载任务

SDImageCache 处理内存缓存和磁盘缓存 SDImageCacheConfig 缓存配置

SDWebImageManager 将图片下载和图片缓存组合起来 SDWebImagePrefetcher 预下载图片 SDWebImageTransition 图片变换

#### 缓存策略

Memory 和 Disk 双缓存

```objective-c
@interface SDImageCache()

#pragma mark - Properties

@property (strong, nonatomic, nonnull) NSCache *memCache;
```

menCache用于对图片的 Memory Cache。SDWebImage还实现了一个叫做 AutoPurgeCache 的类。相比于普通的NSCache, 它提供了一个在内存紧张时释放缓存的能力

```objective-c
@interface AutoPurgeCache: NSCache

@end

@implementation AutoPurgeCache

- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    #if SD_UIKIT
     
     [NSNotificationCenter defaultCenter] addObserver:self selector(romoveAllObjects) name: UIApplicationDidReceiveMemoryWarningNotification object:nil];
     
    #endif
    
  }
  return self
}

@end
```

该通知是接收系统的内存警告通知，然后清除掉自身的图片缓存。NSCache是一个类似于NSDictionary的集合类，用于在内存中储存我们要缓存的数据。

Disk Cache 文件缓存 SDWebImage会将图片存放在NSCachesDirectory 目录中：

```objective-c
- (nullabel NSString *)makeDiskCachePath:(nonnull NSString *)fullNamaspace {
   NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
   reture [path[0] stringByAppendingPathComponent: fullNamespace];

}
```

然后为每一个缓存文件生成一个md5 文件名，存放到文件中。

#### 整体机制

```objective-c
// 读取图片
[imageView sd_setImageWithURL:[NSURL URLWithString:@""]];

//sd_setImageWithURL 内部会调用 SDWebImageManager 的 downloadImageWithRUL 方法来处理这个图片 URL：
id<SDWebImageOperation> operation = [SDWebImageManager sharedManager] downloadImageWithURL:url options: options progress: progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

}]; 

//SDWebImageManager 内部 downloadImageWithURL 方法先使用 SDImageCache 类的 queryDiskCacheForKey 方法， 查询图片缓存

operation.cacheOperation = [self.imageCache queryDiskCacheForKey: key] done:^(UIImage *image, SDImageCacheType cacheType) {

}

// queryDiskCacheForKey 方法内部，先会查询 Memory Cache 
UIImage *image = [slef imageFromMemoryCacheForKey: key];
if (image) {
    doneBlock(image, SDImageCacheTypeMemory);
    retrun nil;
}

//如果 Memory Cache 查不到，就会查询 Disk Cache
dispatch_async(self.ioQueue, ^{
    if (operation.isCancelled) {
        return;
    }

@autoreleasepool {
    UIImage *diskImage = [self diskImageForKey: key];
    if (diskImage && self.shouldCacheImagesInMemory) {
        NSUInteger cost = SDCacheCostForImage(diskImage);
        [self.menCache setObject:disImage forKey: key cost: cost];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        doneBlock(diskImage, SDImageCacheTypeDisk);
    })

}

})

// 查询 Disk Cache 如果查询成功，会把得到的图片再次设置到 Memory Cache 中。然后之间返回缓存数据，如果不成工，就开始请求网络：

id <SDWebImageOperation> subOperation = [self.imageDownloader downloadImageWidthURL:url options:downloaderOptions progress:progressBlock completed:^(UIImage *downloadedImage, NSData *data, NSError *error, BOOL finished)] {

}

//请求网络使用的是iamgeDownloader 属性，如果下载失败，会把失败的图片地址写入failedURLs 集合：
if (error.code != NSURLErrorNotConnectedToInternet && error.code != NSURLErrorCancelled && error.code != NSURLErrorTimedOut error.code != NSURLErrorInternationalRoamingOff && error.code != NSURLErrorDataNotAllowed && error.code != NSRULErrorConnotFindHost && error.code != NSURLErrorCannotConnectToHost) {
    @synchronized(slef.failedURLs) {
        [self.failedURLs addObject: url];
    }

}

//如果下载成功，接下来就会使用 [self.imageCache storeImage] 方法将它写入缓存，并且调用 completedBlock 告诉前端显示图片

if (downloadeImage && finished) {
    [self.imageCache stroeImage:downloadedImage recalculateFromImage:NO imageData:data forKey:key toDisk:cacheOnDisk];
}

dispatch_main_sync_safe(^{
    if (strongOperation && !strongOperation.isCancelled) {
        completedBlock(downloadedImage, nil, SDImageCacheTypeNone, finished, url);
    }
})

```

#### 是否要重试失败的 URL

可以在加载图片的时候设置 SDWebImageRetryFailed 标记，这样SDWebImage 就会加载之前失败过的图片了。failedURLs属性，这个属性实在内存中储存中，如果图片加载失败，SDWebImage 会在本次APP会话中都不再重试这张图片，如果超时失败不记在内。如果需要每次都加载，可以带上SDWebImageRetryFailed 标记

```objective-c
[_iamge sd_setImageWithURL:[NSURL URLWithString:@""]placeholderImagenol options:SDWebImageRetryFailed];
```

#### Diak 缓存清理策略

SDWebImage 会在每次APP结束的时候执行清理任务。清理缓存的规则分两步进行。第一步先清除掉过期的缓存文件。如果清除掉过期的缓存之后，空间还不够。那么就继续按文件时间从早到晚排序，先清除最早的缓存文件，直到剩余空间达到要求。

```
@interface SDImageCache: NSObject

@property (nonatomic, assign) NSInteger maxCacheAge;
@property (nonatomic, assign) NSUInteger maxCacheSize;
 
// maxCacheAge 是文件缓存的时长，SDWebImage 会注册两个通知
[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanDisk) name:UIApplicationWillTerminateNotification object:nil];

[NSNotificationCenter defaultCenter] addObser:self selector:@selector(backgroundCleanDisk) name:UIApplicationDidEnterBackgroundNotification object:nil];

// 分别在应用进入后台和结束的时候，遍历所有的缓存文件，如果缓存文件超过maxCacheAge 中指定的时长，就会被删除掉。
// 同样的，maxCacheSize 控制SDImageCache 所允许的最大缓存空间。如果清理完过期文件后缓存空间依然没达到 maxCacheSize 的要求，那么就会继续清理旧文件，直到缓存空间达到要求为止。

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week

if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
    // 清理缓存代码
}
// currentCacheSize 代表当前图片缓存占用的空间。只有在maxCacheSize 大于0 并且当前缓存空间大于 maxCacheSize 的时候才进行第二步的缓存清理。默认情况下SDWebImage 不对缓存大小设限制的，App 中图片缓存可以沾满整个设备。

[SDImageCache shardImageCache].maxCacheSize = 1024 * 1024 * 50; //50M
```

####  常见面试题

| 序号 |                   问题                   | 答案                                                         | 代码                                              |
| ---- | :--------------------------------------: | ------------------------------------------------------------ | ------------------------------------------------- |
| 1    | 清空缓存 `clearDisk`和 `cleanDisk`区别？ | `cleanDisk`:清楚过期缓存，计算当前缓存的`大小`，和设置的最大缓存数量比较，如果超出那么会继续删除（按照文件了创建的先后顺序)过期时间：`7`天 ; `clearDisk`: 粗暴的直接删除，然后从新创建 | \                                                 |
| 2    | 如何取消当前所有所有操作`NSOperation`？  | 取消所有操作对象                                             | `[[SDWebImageManager sharedManager] cancelAll];`  |
| 3    |              `最大并发数`？              | max =`6`                                                     | `_downloadQueue.maxConcurrentOperationCount = 6;` |
| 4    |     内存`文件`的保存`名称`如何处理？     | 拿到图片的URL路径，对该路径进行`MD5`加密                     | \                                                 |
| 5    |    该框架内部对`内存警告`的处理方式？    | 内部通过监听`通知Notification`进行清理缓存                   | \                                                 |
| 6    |         如何判断`图片`的`类型`？         | 在判断图片类型时候只匹配`第一个字节`                         | \                                                 |
| 7    |        该框架对`缓存`处理的方式？        | 以前： 内存缓存用可变字典dic; 本第三方用`NSCache`            | \                                                 |
| 8    |         队列中的任务的处理方式？         | `FIFO`：先进先出`First In First Out`                         | \                                                 |
| 9    |             如何`下载`图片？             | 发送网络请求 `NSURLConnection`                               | \                                                 |
| 10   |             请求超时`时限`？             | `15s`                                                        | `_downloadTimeout = 15.0;`                        |


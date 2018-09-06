//
//  MessageViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/9.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "MessageViewController.h"
#import "BaseTableView.h"

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


@end

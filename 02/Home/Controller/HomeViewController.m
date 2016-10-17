//
//  HomeViewController.m
//  02
//
//  Created by fzxa on 16/9/16.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import <MJExtension.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>

#import "WebViewController.h"
#import "HomeViewController.h"
#import "HomeViewNewsCell.h"


#import "TSEHttpTool.h"
#import "HomeViewNewsView.h"
#import "HomeViewNewsModel.h"
#import "HomeViewNewsCell.h"
#import "HomeViewNewsCellFrame.h"

#import "LatestFocusNewsModel.h"
#import "HomeFocusView.h"

#import "Common.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *latestNewsFrame;
@property (nonatomic, strong) NSMutableDictionary *paras;
@property (nonatomic, strong) NSArray *latestNews;
@property (nonatomic, strong) NSArray *focusNews;
@property (nonatomic, strong) NSMutableArray *imgsArr;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) HomeFocusView *loopView;

@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int imgIndex;



@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    // 下拉加载最新数据
    [self pullDownToRefreshLatestNews];
    
    // 上拉加载更多数据
    [self pullUpToLoadMoreNews];

}

/**
 *  加载最新数据
 */
-(void) pullDownToRefreshLatestNews
{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestLatestNews)];
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];

}

/**
 *  加载更多数据
 */
-(void)pullUpToLoadMoreNews
{
    //防止循环调用
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreLatestNews];
    }];
}

/**
 *  加载更多数据
 */
-(void)requestMoreLatestNews
{
    _count += 10;
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[kLimit] = @10;
    _offset = _count; // 每次上拉刷新参数"offset"会动态加10
    paras[kOffset] = [NSString stringWithFormat:@"%d", _offset];
    paras[kType] = @1;
    //paras[kVer] = @"6.2";
    
    [TSEHttpTool get:kGetCarNewsURL params:paras success:^(id json) {
        
        // 通过数组字典返回模型，该数组中装的都是XZMDoesticCarNews模型
        NSArray *latestNewsArr = [HomeViewNewsModel mj_objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        for (HomeViewNewsModel * news in latestNewsArr) {
            // 判断是否为广告
            if (!news.adIndex) { // 不是的话加进数组
                HomeViewNewsCellFrame *f = [[HomeViewNewsCellFrame alloc] init];
                f.homeViewNews = news;
                [newsArray addObject:f];
            }
        }
        
        [self.latestNewsFrame addObjectsFromArray:newsArray];
        // 刷新tableView
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"fail------%@", error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

/**
 *  加载最新数据
 */
-(void)requestLatestNews
{
    [TSEHttpTool get:kGetCarNewsURL params:self.paras success:^(id json) {
        NSLog(@"carnews------/n%@", json);
        
        //获取滚动新闻
        self.focusNews = [LatestFocusNewsModel mj_objectArrayWithKeyValuesArray:json[@"focusList"][@"focusImgs"]];
        NSArray *focusArr = self.focusNews;
        
        //设置table header
        [self setupTableHeaderViewWithFocusNews:self.focusNews];
        
        // 通过数组字典返回模型，该数组中装的都是TSEHomeViewNews模型
        NSArray *latestNewsArr = [HomeViewNewsModel mj_objectArrayWithKeyValuesArray:json[@"newsList"]];
        
        // 创建frame模型对象
        NSMutableArray *newsArray = [NSMutableArray array];
        
        for (HomeViewNewsModel *news in latestNewsArr) {
            
            // 判断是否为广告
            if (!news.adIndex) { // 不是的话加进数组
                HomeViewNewsCellFrame *f = [[HomeViewNewsCellFrame alloc] init];
                f.homeViewNews = news;
                [newsArray addObject:f];
            }
        }
        
        self.latestNewsFrame = newsArray;
        
        // 刷新tableView
        [self.tableView reloadData];
        // 结束刷新状态
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error-------/n%@", error);
        // 结束刷新状态
        [self.tableView.mj_header endRefreshing];
    }];
}


-(void)setupTableHeaderViewWithFocusNews:(NSArray *)focusNewsArr
{
    
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.imgsArr = [NSMutableArray array];
        for (LatestFocusNewsModel *news in focusNewsArr) {
            NSString *urlStr = news.imgURL;
            NSURL *imageUrl = [NSURL URLWithString:urlStr];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            [self.imgsArr addObject:image];
        }
        
        // 当图片下载完成后，在主线程设置tableHeaderView的数据
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:3.0];
        });
    });

}


-(void) setupTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    //下拉距离
    [tableView setContentInset:UIEdgeInsetsMake(0, 0, 100, 0)];
    //去掉分割线
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setBackgroundColor:SETCOLOR(248, 248, 248)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    HomeFocusView *loopView = [[HomeFocusView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width / 1.8f)];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.loopView = loopView;
    
    
//    HomeFocusView *loopView = [[TSEXCARLoopView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width / 1.8f)];
//    loopView.delegate = self;
//    self.tableView.tableHeaderView = loopView;
//    self.loopView = loopView;
    
//    HomeFocusView *loopView = [[HomeFocusView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 1.8f)];
//    loopView.delegate = self;
//    self.tableView.tableHeaderView = loopView;
//    self.loopView = loopView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.latestNewsFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeViewNewsCell *cell = [HomeViewNewsCell cellWithTableView:tableView];
    
    cell.homeViewNewsCellFrame = self.latestNewsFrame[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewNewsCellFrame *f = self.latestNewsFrame[indexPath.row];
    return f.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeViewNewsCellFrame *f = self.latestNewsFrame[indexPath.row];
    HomeViewNewsModel *news = f.homeViewNews;
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.urlStr = news.newsLink;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - lazy load
- (NSMutableDictionary *)paras {
    if (!_paras) {
        _paras = [NSMutableDictionary dictionary];
        _paras[kLimit] = @20;
        _paras[kOffset] = @0;
        _paras[kType] = @1;
        _paras[kVer] = @"6.2";
    }
    
    return _paras;
}

@end

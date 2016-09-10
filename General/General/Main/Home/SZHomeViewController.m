//
//  SZHomeViewController.m
//  General
//
//  Created by llbt on 16/8/30.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZHomeViewController.h"
#import "SZNavigationController.h"
#import "SZUser.h"
#import "SZHotCollectionViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "SZLiveViewController.h"


@interface SZHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation SZHomeViewController

-  (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新";
    
    [self setupCollectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)getData {
    NSString *path = [NSString stringWithFormat:@"/Room/GetNewRoomOnline?page=%d",1];
    [SZNetworkTool getNetworkRequestWithUrlString:path params:nil succeed:^(id result) {
        self.dataSource = [SZUser mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth - 2 * 2) / 3.0, 100);
    layout.minimumInteritemSpacing = 2;
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[SZHotCollectionViewCell class] forCellWithReuseIdentifier:@"SZHotCollectionViewCell"];
}


#pragma mark -- delegare
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SZHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SZHotCollectionViewCell" forIndexPath:indexPath];
    cell.user = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d",indexPath.row);
    SZLiveViewController *live = [[SZLiveViewController alloc] init];
    live.user = self.dataSource[indexPath.row];
    [self presentViewController:live animated:YES completion:nil];
}

@end

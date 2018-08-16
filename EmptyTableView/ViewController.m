//
//  ViewController.m
//  study
//
//  Created by 秦传龙 on 2018/8/13.
//  Copyright © 2018年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "TestDemo.h"
#import <MJRefresh/MJRefresh.h>


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, CLEmptyDefaultViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger section;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.section = [self getSection];
    [self createTestTable];
}

- (NSInteger)getSection {
    sleep(arc4random()%2+1);
    NSInteger section = arc4random()%2;
    return section;
}

- (void)createTestTable {
    UITableView *table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    // 你只需要设置一句代码即可使用
    table.emptyView = [TestDemo emptyDefultViewWithDelegate:self];
    
    table.delegate = self;
    table.dataSource = self;
    UIEdgeInsets edgeInsets = table.contentInset ;
    edgeInsets.top = -20;
    table.contentInset = edgeInsets;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:table];
    self.tableView = table;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.section = [weakSelf getSection];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}


#pragma mark -- CLEmptyDefaultViewDelegate
- (void)emptyDefaultViewDidClickRefresh:(CLEmptyDefaultView *)emptyView {
    [self.tableView.mj_header beginRefreshing];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld行，第%ld组",indexPath.row,indexPath.section];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.section = [self getSection];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

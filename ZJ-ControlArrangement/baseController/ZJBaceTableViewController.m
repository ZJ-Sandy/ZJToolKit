//
//  ZJBaceTableViewController.m
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/26.
//  Copyright © 2019 志杰. All rights reserved.
//

#import "ZJBaceTableViewController.h"

@interface ZJBaceTableViewController ()

@end

@implementation ZJBaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupSignleTableView{
    [self setupUISingleTableViewWithStyle:UITableViewStylePlain];
}

- (void)setupUISingleTableViewWithStyle:(UITableViewStyle)style{
    _tableViewStyle = style;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setTableViewRefreshType:(TQTVRefreshType)refreshType{
    if (!self.tableView) {
        return;
    }
    
    _tableViewRefreshType = refreshType;
    if (refreshType & TQTVRefreshTypeHeader) {
        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    }
    if (refreshType & TQTVRefreshTypeFooter) {
        self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    
}

#pragma mark - ------ Table view data source -----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell mk_cellWithDefaultStyleTableView:tableView];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArray.count ? self.datasArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJ_SCREEN_WIDTH, 16)];
    view.backgroundColor = [UIColor lightTextColor];
    return view;
}


// 下拉刷新触发的方法
- (void)loadLastData{
    [self loadDataSource];
}
// 上拉刷新触发的方法
- (void)loadMoreData{
    [self loadDataSource];
}
// 加载数据源
- (void)loadDataSource {
    [self.datasArray removeAllObjects];
}

#pragma mark - ***** lazy ******
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.separatorColor = [UIColor lightGrayColor];
        tableView.tableFooterView = [UIView new];
        tableView.rowHeight = 44;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        _tableView = tableView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle{
    if (!_tableViewStyle) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return _tableViewStyle;
}

- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

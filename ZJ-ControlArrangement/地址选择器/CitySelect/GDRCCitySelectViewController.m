//
//  GDRCCitySelectViewController.m
//  GDRCIphone
//
//  Created by laijun on 2019/1/2.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "GDRCCitySelectViewController.h"
#import "GDRCZoneTableViewCell.h"
#import "GDRCCityTableViewCell.h"
//#import "RCProgressHub.h"
//#import "RCMemoryCache.h"

@interface GDRCCitySelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *cityTableView; //左边城市列表
@property (nonatomic, strong) GDRCZoneViewControl *zoneViewControl; //右边地区列表
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) NSIndexPath *lastIndexPath;
@property (nonatomic, strong) NSString *selectedCity; //已选择城市
@property (nonatomic, strong) NSString *selectedZone; //已选择区
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, strong) UIColor *normalColor;

@end

@implementation GDRCCitySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _highlightColor = [UIColor orangeColor];
    _normalColor = [UIColor blackColor];
    
    [self setupUI];
    
    
    //请求数据
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityList.json" ofType:nil]];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArray = (NSArray *)jsonObject;
    
    if(dataArray && dataArray.count > 0){
        self.dataSource = [dataArray copy];
        [self.cityTableView reloadData];
//        //默认
//        NSDictionary *dic = self.dataSource[0];
//        NSDictionary *cityDic = [dic objectForKey:@"sysRegionDto"];
//        NSString *areaName = cityDic[@"areaName"];
//        NSString *areaNameAll = [NSString stringWithFormat:@"%@ (全部)",areaName];
//        NSArray *zoneArray = [dic objectForKey:@"children"];
//        NSMutableArray *mutableZoneArray = [NSMutableArray arrayWithArray:zoneArray];
//        [mutableZoneArray insertObject:@{@"areaName":areaNameAll} atIndex:0];
        
        NSDictionary *dic = self.dataSource[0];
        NSString *areaName = dic[@"name"];
        NSString *areaNameAll = [NSString stringWithFormat:@"%@ (全部)",areaName];
        NSMutableArray *mutableZoneArray = [NSMutableArray arrayWithArray:dataArray];
        [mutableZoneArray insertObject:@{@"areaName":areaNameAll} atIndex:0];

        [self.zoneViewControl rc_reloadData:mutableZoneArray];
        _verticalLine.hidden = NO;
    }
//    else{
//        [self requestCityData];
//        self.dataSource = @[];
//    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)setupUI{
    
    self.title = @"地区选择";
//    self.customNavigationBarBgView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:item];
    [self.navigationItem setLeftBarButtonItems:@[item]];
    
    //顶部横线
//    UIColor *lineColor = [UIColor colorWithHexString:@"#E9E9E9"];
    UIColor *lineColor = [UIColor blackColor];
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = lineColor;
    [self.view addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.top.offset((ZJ_isPhoneXSeries?84:64));
    }];
    
    _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height) style:UITableViewStylePlain];
    _cityTableView.backgroundColor = [UIColor whiteColor];
    _cityTableView.dataSource = self;
    _cityTableView.delegate = self;
    _cityTableView.showsVerticalScrollIndicator = NO;
    _cityTableView.showsHorizontalScrollIndicator = NO;
    _cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _cityTableView.estimatedRowHeight = 0;
    _cityTableView.estimatedSectionHeaderHeight = 0;
    _cityTableView.estimatedSectionFooterHeight = 0;
    
    if (kIOS11_OR_LATER) {
        _cityTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_cityTableView];
    [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(horizontalLine.mas_bottom).offset(0);
        make.left.bottom.offset(0);
        make.width.offset(100);
    }];
    
    //竖直分割线
    _verticalLine = [[UIView alloc] init];
    _verticalLine.hidden = YES;
    _verticalLine.backgroundColor = lineColor;
    [self.view addSubview:_verticalLine];
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.offset(1);
        make.left.mas_equalTo(_cityTableView.mas_right).offset(0);
    }];
    
    GDRCZoneViewControl *cityZoneControl = [[GDRCZoneViewControl alloc] init];
    cityZoneControl.delegate = self;
    UIView *zoneView = cityZoneControl.view;
    [self.view addSubview:zoneView];
    [zoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verticalLine.mas_right).offset(0);
        make.right.offset(0);
        make.top.mas_equalTo(_cityTableView.mas_top);
        make.bottom.mas_equalTo(_cityTableView.mas_bottom);
    }];
    self.zoneViewControl = cityZoneControl;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.dataSource.count>0){
        return self.dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _dataSource[indexPath.row];
    
    static NSString *reuseId = @"city";
    
    GDRCCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell){
        cell = [[GDRCCityTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *areaName = [self areaNameInRegion:dic];
    
    if(_selectedCity && [_selectedCity isEqualToString:areaName]){
        cell.leftBar.hidden = NO;
        cell.contentLabel.textColor = _highlightColor;
        _lastIndexPath = indexPath;
    }else{
        cell.leftBar.hidden = YES;
        cell.contentLabel.textColor = _normalColor;
    }
   
    cell.contentLabel.text = areaName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(_lastIndexPath.row == indexPath.row) return;
    
    GDRCCityTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(!_lastIndexPath){
        cell.leftBar.hidden = NO;
        cell.contentLabel.textColor = _highlightColor;
        self.lastIndexPath = indexPath;
        
    }else{
        
        GDRCCityTableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastIndexPath];
        oldCell.contentLabel.textColor = _normalColor;
        cell.contentLabel.textColor = _highlightColor;
        oldCell.leftBar.hidden = YES;
        cell.leftBar.hidden = NO;
        self.lastIndexPath = indexPath;
    }
    
    //计算tableview contentoffset
    CGFloat cellY = cell.frame.origin.y;
    CGPoint finalPoint = CGPointZero;
    if(cellY + _cityTableView.frame.size.height <= _cityTableView.contentSize.height){
        finalPoint = CGPointMake(0, cellY);
    }else{
        finalPoint = CGPointMake(0, _cityTableView.contentSize.height - _cityTableView.frame.size.height);
    }
    
    [UIView animateWithDuration:.5 animations:^{
        _cityTableView.contentOffset = finalPoint;
    }];
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *areaName = [self areaNameInRegion:dic];
    self.selectedCity = areaName;
    
    NSString *areaNameAll = [NSString stringWithFormat:@"%@ (全部)",areaName];
//    NSArray *zoneArray = [dic objectForKey:@"children"];
    NSArray *zoneArray = [self.dataSource copy];
    NSMutableArray *mutableZoneArray = [NSMutableArray arrayWithArray:zoneArray];
    [mutableZoneArray insertObject:@{@"areaName":areaNameAll} atIndex:0];
    
    [_zoneViewControl rc_reloadData:mutableZoneArray];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneSelect:(id)zoneDic{
    [self.navigationController popViewControllerAnimated:YES];
    if(self.finishBlock){
        //记录选择数据
        NSDictionary *cityDic = self.dataSource[_lastIndexPath.row];
        NSString *saveCity = [self areaNameInRegion:cityDic];
        NSString *saveZone = [self organizeNameInOrganize:zoneDic];
        NSString *organizeId = [self organizeIdInOrganize:zoneDic];
        NSString *areaCode = [self areaCodeInOrganize:zoneDic];
        NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
        [saveDic setValue:saveCity forKey:@"selectedCity"];
        [saveDic setValue:saveZone forKey:@"selectZone"];
        [saveDic setValue:organizeId forKey:@"organizeId"];
        [saveDic setValue:areaCode forKey:@"areaCode"];
        [saveDic setObject:_zoneViewControl.dataSource forKey:@"zoneDataSource"];
        self.finishBlock(saveDic);
        
    }
}

- (NSString *)areaNameInRegion:(NSDictionary *)dic{
//    NSDictionary *cityDic = [dic objectForKey:@"sysRegionDto"];
    return dic[@"name"];
}

- (NSString *)organizeNameInOrganize:(NSDictionary *)dic{
//    NSDictionary *organizeDic = [dic objectForKey:@"sysOrganizeDto"];
    return dic[@"name"];;
}

- (NSString *)organizeIdInOrganize:(NSDictionary *)dic{
//    NSDictionary *organizeDic = [dic objectForKey:@"sysOrganizeDto"];
    return dic[@"value"];;
}

- (NSString *)areaCodeInOrganize:(NSDictionary *)dic{
//    NSDictionary *organizeDic = [dic objectForKey:@"sysOrganizeDto"];
    return dic[@"value"];;
}


@end


@implementation GDRCZoneViewControl

- (void)viewDidLoad{
    [super viewDidLoad];
    _dataSource = [NSArray array];
    [self setupUI];
}

- (void)setupUI{
    _zoneTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _zoneTableView.backgroundColor = [UIColor whiteColor];
    _zoneTableView.dataSource = self;
    _zoneTableView.delegate = self;
    _zoneTableView.showsVerticalScrollIndicator = NO;
    _zoneTableView.showsHorizontalScrollIndicator = NO;
    _zoneTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _zoneTableView.estimatedRowHeight = 0;
    _zoneTableView.estimatedSectionHeaderHeight = 0;
    _zoneTableView.estimatedSectionFooterHeight = 0;
    if (kIOS11_OR_LATER) {
        _zoneTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _zoneTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    
    self.view = _zoneTableView;
    
}

- (void)rc_reloadData:(NSArray *)data{
    self.dataSource = data;
    [_zoneTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.dataSource.count>0){
        return self.dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _dataSource[indexPath.row];
    
    UITableViewCell *cell;
    if(indexPath.row == 0){
       cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
        if(!cell){
            cell = [[GDRCZoneTitleTableViewCell alloc] init];
            cell.userInteractionEnabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [(GDRCZoneTitleTableViewCell *)cell bindData:dic];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cityZone"];
        if(!cell){
            cell = [[GDRCZoneTableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSMutableDictionary *bindDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [bindDic setValue:self.selectedZone forKey:@"selectedZone"];
        [(GDRCZoneTableViewCell *)cell bindData:bindDic];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.delegate && [self.delegate respondsToSelector:@selector(doneSelect:)]){
        [self.delegate doneSelect:self.dataSource[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


@end

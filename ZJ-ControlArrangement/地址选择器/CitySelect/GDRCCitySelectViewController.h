//
//  GDRCCitySelectViewController.h
//  GDRCIphone
//
//  Created by laijun on 2019/1/2.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "ZJBaceTableViewController.h"

typedef void(^onDoneBlock)(NSDictionary *addressDic);

@protocol GDRCCitySelectDelegate <NSObject>

- (void)doneSelect:(id)zoneDic;

@end

@interface GDRCCitySelectViewController : ZJBaceTableViewController<GDRCCitySelectDelegate>

@property (nonatomic, copy) onDoneBlock finishBlock;

@end

@interface GDRCZoneViewControl : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *zoneTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *selectedZone;
@property (nonatomic, weak) id<GDRCCitySelectDelegate> delegate;

- (void)rc_reloadData:(NSArray *)data;

@end


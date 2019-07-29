//
//  ZJBaceTableViewController.h
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/26.
//  Copyright © 2019 志杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaceTableViewController : ZJBaceViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView; /*!< main tableView */
@property (nonatomic, assign) UITableViewStyle tableViewStyle; /*!< 初始化init的时候 设置 tableView的样式才有效 */
@property (nonatomic, assign) TQTVRefreshType tableViewRefreshType; /*!< 上拉刷新 */

@property (nonatomic, strong) NSMutableArray *datasArray; /*!< 数据源设置 */

- (void)setupSignleTableView;
- (void)setupUISingleTableViewWithStyle:(UITableViewStyle)style;
- (void)setTableViewRefreshType:(TQTVRefreshType)refreshType;
@end

NS_ASSUME_NONNULL_END
